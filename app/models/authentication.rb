class Authentication < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # TODO: Add more validations.

  # Creates an authentication given a user and an omniauth hash.
  def self.create_with_omniauth!(hash, user)
    auth = Authentication.create(:user_id => user.id,
                                 :uid => hash.uid,
                                 :provider => hash.provider,
                                 :token => hash.credentials.token,
                                 :secret => hash.credentials.secret,
                                 :image => hash.info.try(:image),
                                 :url => hash.info.try(:urls).try(:public_profile))
    auth
  end

end