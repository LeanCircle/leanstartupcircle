class Authentication < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # TODO: Add more validations.
  # TODO: Add method to pull in authentications from omniauth including token and secret.
  ## Creates an authentication given a user and an omniauth hash.
  #def self.create_with_omniauth!(hash, user)
  #  if hash['provider'] == "twitter"
  #    url = "http://twitter.com/" + hash['user_info']['nickname']
  #    image = Twitter.profile_image(hash['user_info']['nickname'], :size => 'bigger')
  #  elsif hash['provider'] == "facebook"
  #    url = "http://www.facebook.com/profile.php?id=" + hash['uid']
  #    image = hash['user_info']['image']
  #  end
  #  auth = Authentication.create(:user_id => user.id,
  #                               :uid => hash['uid'],
  #                               :provider => hash['provider'],
  #                               :token => hash['credentials']['token'],
  #                               :secret => hash['credentials']['secret'],
  #                               :image => image,
  #                               :url => url)
  #  auth
  #end

end
