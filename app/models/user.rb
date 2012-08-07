class User < ActiveRecord::Base
  # default devise modules are:
  # :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable
  # others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :omniauthable, :registerable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :public_profile_url, :uid, :provider

  def self.find_for_linkedin_oauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
  end

  def self.create_from_linkedin_oauth(auth)
    user = User.create(
      first_name:auth.info.first_name,
      last_name:auth.info.last_name,
      public_profile_url:auth.info.urls.public_profile,
      provider:auth.provider,
      uid:auth.uid
      )
  end

end
