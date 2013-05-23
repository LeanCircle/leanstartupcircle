class Authentication < ActiveRecord::Base

  belongs_to :user
  has_many :groups #, :primary_key => "uid", :foreign_key => "organizer_id" # TODO: Scope this to :provider => "meetup"

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # TODO: Add more validations.

  # Creates an authentication given a user and an omniauth hash.
  def self.find_or_create_with_omniauth!(hash, user=nil)
    raise ArgumentError, "Hash is missing." if hash.blank?
    auth = Authentication.find_by_provider_and_uid(hash['provider'], hash['uid'].to_s)
    auth ||= new(:name => hash.info.name,
                 :uid => hash.uid,
                 :provider => hash.provider,
                 :token => hash.credentials.try(:token),
                 :secret => hash.credentials.try(:secret),
                 :image => hash.info.try(:image),
                 :url => (hash.info.try(:urls).try(:public_profile) || hash.info.try(:urls).try(:twitter)),
                 :description => hash.info.try(:description),
                 :location => hash.info.try(:location))
    auth.user_id = user.id if user
    groups = Group.fetch_meetups_with_authentication(auth) if auth.provider == 'meetup'
    groups ||= []
    if auth.save
      return auth, groups
    else
      raise StandardError, "The resulting authentication was invalid."
    end
  end

end


