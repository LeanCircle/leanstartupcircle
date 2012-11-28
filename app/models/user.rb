class User < ActiveRecord::Base
  # default devise modules are:

  has_many :authentications

  extend FriendlyId
  friendly_id :name, use: :slugged

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
  attr_accessible :uid,
                  :provider,
                  :first_name,
                  :last_name,
                  :public_profile_url,
                  :email,
                  :zipcode,
                  :user_type,
                  :company_name,
                  :phone,
                  :password,
                  :password_confirmation


  def name
    #self.first_name + " " + self.last_name
  end

  # Omniauth + Devise methods

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
