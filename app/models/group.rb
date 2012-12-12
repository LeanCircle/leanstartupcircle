class Group < ActiveRecord::Base

  belongs_to :authentication, :primary_key => "uid", :foreign_key => "organizer_id" # TODO: scope this to :provider => "meetup"
  belongs_to :user

  attr_accessor :meetup_identifier

  validates_presence_of :name
  validates_uniqueness_of :name,
                          :meetup_id,
                          :meetup_link, :allow_blank => true

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |group, results|
    if geo = results.first
      group.city = geo.city
      group.province = geo.state_code
      group.country_code = geo.country_code
      group.country = geo.country
    end
  end
  after_validation :geocode, :reverse_geocode

  acts_as_gmappable :address => "address"
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :approved, where(:approval => true)

  def link
    if !meetup_link.blank?
      return meetup_link
    elsif !facebook_link.blank?
      return facebook_link
    elsif !linkedin_link.blank?
      return linkein_link
    elsif !googleplus_link.blank?
      return googleplus_link
    elsif !other_link.blank?
      return other_link
    end
  end

  def address
    [city, province, country].compact.join(', ')
  end

  def address_no_country
    [city, province].compact.join(', ')
  end

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.city}, #{self.province}, #{self.country}"
  end

  def self.fetch_from_meetup(query, group = nil )
    return if query.blank?
    init_rmeetup
    query = query.sub(/^https?\:\/\//, '').sub(/\/+$/,'') # Remove http:// and trailing slashes
    if !!(query =~ /^[-+]?[0-9]+$/) # If the query is a number, assume it's a group_id
      response = RMeetup::Client.fetch( :groups,{ :group_id => query }).first
    elsif query.include?("meetup.com")
      uri = URI::parse("http://" + query).path.sub(/\/*/,"").sub(/\/+$/,'') # Setup string for use as group_urlname
      response = RMeetup::Client.fetch( :groups,{ :group_urlname => uri }).first
    else
      response = RMeetup::Client.fetch( :groups,{ :domain => query }).first
    end
    save_meetup_api_response(response, group)
  end

  def self.fetch_meetups_with_authentication(auth)
    init_rmeetup
    responses = RMeetup::Client.fetch( :groups,{ :organizer_id => auth.uid })
    responses.each do |response|
      save_meetup_api_response(response).save
    end
  end

  def self.save_meetup_api_response(response, group = Group.new)
    unless response.blank?
      group.name = response.try(:name)
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
    end
    group.authentication.user.groups << group if group.organizer_id && group.authentication.try(:user)
    return group
  end

  private

  def self.init_rmeetup
    RMeetup::Client.api_key = AppConfig['meetup_api_key']
  end

end