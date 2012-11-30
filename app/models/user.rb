class User < ActiveRecord::Base

  has_many :authentications

  extend FriendlyId
  friendly_id :name, use: :slugged

  # TODO: Make Geomappable
  #geocoded_by :zip_code
  #reverse_geocoded_by :latitude, :longitude
  #acts_as_gmappable :zip_code => "zip_code"

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :recoverable,
         :rememberable,
         :trackable,
         :lockable,
         :confirmable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :uid,
  #                :provider,
  #                :email,
  #                :zipcode,
  #                :company_name,
  #                :phone,
  #                :password,
  #                :password_confirmation

  def first_name
    name.sub(/ .*/, '') rescue ''
  end

  def identifier
    name.blank? ? email : name
  end

  def email_header
    "\"#{name}\" <#{email}>"
  end

  def admin?
    role == 'admin' ? true : false
  end

  # Omniauth + Devise methods

  # Given an omniauth hash, returns the user if there is one or creates one.
  def self.authenticate_or_create_with_omniauth!(hash)
    user = Authentication.find_by_provider_and_uid(hash['provider'], hash['uid']).try(:user)
    return user if user
    user = User.create_with_omniauth!(hash)
    Authentication.create_with_omniauth!(hash, user)
    user
  end

  # Given an omniauth hash, creates a user and returns it.
  def self.create_with_omniauth!(hash)
    info = hash.info
    user = new( :name => info.try(:name),
                :phone => info.try(:phone))
    user.save(:validate => false )
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end