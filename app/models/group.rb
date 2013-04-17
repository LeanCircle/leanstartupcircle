class Group < ActiveRecord::Base
  attr_accessor :meetup_identifier

  belongs_to :authentication, :primary_key => "uid", :foreign_key => "organizer_id" # TODO: scope this to :provider => "meetup"
  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name,
                          :meetup_id,
                          :meetup_link, :allow_blank => true
  after_validation :geocode, :reverse_geocode

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |group, results|
    if geo = results.first
      group.city = geo.city
      group.province = geo.state_code
      group.country_code = geo.country_code
      group.country = geo.country
    end
  end
  acts_as_gmappable :validation => false,
                    :process_geocoding => false,
                    :address => "address"

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :approved, where(:approval => true)

  def link
    [meetup_link,
     facebook_link,
     linkedin_link,
     googleplus_link,
     other_link,
     twitter_link].compact.first
  end

  def address
    [city, province, country].compact.join(', ')
  end

  def address_no_country
    [city, province].compact.join(', ')
  end

  def self.fetch_from_meetup(query)
    init_rmeetup
    method = query_method(query)
    query = clean_query(query)
    response = RMeetup::Client.fetch( :groups,{ method => query }).first
    create_from_meetup_api_response(response)
  end

  def self.fetch_meetups_with_authentication(auth)
    init_rmeetup
    responses = RMeetup::Client.fetch( :groups,{ :organizer_id => auth.uid })
    meetups_added ||= []
    responses.each do |response|
      meetups_added << create_from_meetup_api_response(response)
    end
    return meetups_added
  rescue
    return meetups_added ||= []
  end

  def self.create_from_meetup_api_response(response)
    group = Group.new

    # Assign attributes from response
    group.name = response.try(:name) if response.try(:name) && group.name.blank?
    group.description = response.try(:description)
    group.meetup_id = response.try(:id)
    group.organizer_id = response.try(:organizer).try(:[], 'member_id')
    group.meetup_link = response.try(:link)
    group.city = response.try(:city)
    group.country_code = response.try(:country)
    group.province = response.try(:state)
    group.latitude = response.try(:lat)
    group.longitude = response.try(:lon)
    group.highres_photo_url = response.try(:group_photo).try(:[], 'highres_link')
    group.photo_url = response.try(:group_photo).try(:[], 'photo_link')
    group.thumbnail_url = response.try(:group_photo).try(:[], 'thumb_link')
    group.join_mode = response.try(:join_mode)
    group.visibility = response.try(:visibility)

    # Try to assign to a user and save.
    group.save
    group.authentication.user.groups << group if group.organizer_id && group.authentication.try(:user)
    return group
  end

  private

  def self.init_rmeetup
    RMeetup::Client.api_key = ENV['MEETUP_API_KEY']
  end

  def self.clean_query(query)
    query = query.sub(/^https?\:\/\//, '').sub(/\/+$/,'').gsub(/\s+/, "")
    query = URI::parse("http://" + query).path.sub(/\/*/,"").sub(/\/+$/,'') if query.include?("meetup.com")
    query
  end

  def self.query_method(query)
    if query =~ /^[-+]?[0-9]+$/ # If the query is a number, assume it's a group_id
      return :group_id
    elsif query.include?("meetup.com")
      return :group_urlname
    else
      return :domain
    end
  end

end