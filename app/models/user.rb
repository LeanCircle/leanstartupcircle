class User < ActiveRecord::Base
  # default devise modules are:
  # :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable
  # others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :omniauthable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :uid, :provider, :first_name, :last_name, :public_profile_url, :email, :zipcode

  def self.find_for_linkedin_oauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
  end

  def self.new_from_linkedin_oauth(auth)
    user = User.new(
      uid:auth.uid,
      provider:auth.provider,
      first_name:auth.info.first_name,
      last_name:auth.info.last_name,
      public_profile_url:auth.info.urls.public_profile
      )
  end

end
