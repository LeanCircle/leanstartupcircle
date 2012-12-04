class User < ActiveRecord::Base

  has_many :authentications
  has_many :meetups, :through => :authentications

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name

  geocoded_by :zip_code
  reverse_geocoded_by :latitude, :longitude do |user,results|
    if geo = results.first
      user.city    = geo.city
      user.state    = geo.state_code
      user.country = geo.country
      user.zip_code = geo.postal_code
    end
  end
  after_validation :geocode, :reverse_geocode

  acts_as_gmappable :zip_code => "address"

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
  #attr_accessible :email,
  #                :zip_code,
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

  # Geocoding methods

  def address
    [city, state, country].compact.join(', ')
  end

  def gmaps4rails_address
    self.zip_code
  end

  # Omniauth + Devise methods

  # Given an omniauth hash, returns the user if there is one or creates one.
  def self.authenticate_or_create_with_omniauth!(hash, user = nil)
    if user
      Authentication.create_with_omniauth!(hash, user)
    elsif user = Authentication.find_by_provider_and_uid(hash['provider'], hash['uid']).try(:user)
      return user
    else
      user = User.create_with_omniauth!(hash)
      Authentication.create_with_omniauth!(hash, user)
    end
    user
  end

  # Given an omniauth hash, creates a user and returns it.
  def self.create_with_omniauth!(hash)
    info = hash.info
    user = new(:name => info.try(:name),
               :phone => info.try(:phone))
    user.save(:validate => false)
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
    super && authentications.nil?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end