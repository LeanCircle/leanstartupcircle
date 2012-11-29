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
    full_name.sub(/ .*/, '') rescue ''
  end

  def identifier
    full_name.blank? ? email : full_name
  end

  def email_header
    "\"#{name}\" <#{email}>"
  end

  def admin?
    role == 'admin' ? true : false
  end

  # Omniauth + Devise methods

  # TODO: Move this stuff to authentications use jokeoff code:
  ## Authentication methods
  #
  #  # Given an omniauth hash, returns the user if there is one or creates one.
  #  def self.authenticate_or_create_with_omniauth!(hash)
  #    user = Authentication.find_by_provider_and_uid(hash['provider'], hash['uid']).try(:user)
  #    return user if user
  #    user = User.create_with_omniauth!(hash)
  #    EmailAddress.create_with_omniauth!(hash, user)
  #    Authentication.create_with_omniauth!(hash, user)
  #    user
  #  end
  #
  #  # Given an omniauth hash, creates a user and returns it.
  #  def self.create_with_omniauth!(hash)
  #    info = hash['user_info']
  #    users_name = info['name']
  #    image = info['image'] unless info['image'].blank?
  #    user = new( :full_name => users_name, :image => image )
  #    user.save(:validate => false )
  #    user
  #  end
  #
  #  # Authenticates a user given an email and password.
  #  def self.authenticate_with_password(email, password)
  #    if @user = EmailAddress.find_by_address(email).try(:user)
  #      if authentication = @user.authentications.find_by_provider('password')
  #        return @user if authentication.secret == BCrypt::Engine.hash_secret(password, authentication.token)
  #      end
  #    end
  #  end


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email if auth.info.email
      user.encrypted_password = Devise.friendly_token[0,20]
      #user.name = auth.info.nickname
    end
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
