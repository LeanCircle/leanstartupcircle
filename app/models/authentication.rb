class Authentication < ActiveRecord::Base

  belongs_to :user
  has_many :groups, :primary_key => "uid", :foreign_key => "organizer_id" # TODO: Scope this to :provider => "meetup"

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # TODO: Add more validations.

  # Creates an authentication given a user and an omniauth hash.
  def self.create_with_omniauth!(hash, user)
    auth = Authentication.create(:user_id => user.id,
                                 :name => hash.info.name,
                                 :uid => hash.uid,
                                 :provider => hash.provider,
                                 :token => hash.credentials.token,
                                 :secret => hash.credentials.secret,
                                 :image => hash.info.try(:image),
                                 :url => (hash.info.try(:urls).try(:public_profile) || hash.info.try(:urls).try(:twitter)),
                                 :description => hash.info.try(:description),
                                 :location => hash.info.try(:location))
    Group.fetch_meetups_with_authentication(auth) if auth.provider == 'meetup'
    auth
  end

end


