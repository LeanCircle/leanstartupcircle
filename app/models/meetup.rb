class Meetup < ActiveRecord::Base

  belongs_to :authentication, :primary_key => "uid", :foreign_key => "organizer_id"

  attr_accessor :meetup_identifier

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable :address => "address"
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :approved, where(:approval => true)

  def user
    authentication.user
  end

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
    [city, state, country].compact.join(', ')
  end

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.city}, #{self.state}, #{self.country}"
  end

  def self.fetch_from_meetup(meetup, query)
    if query.blank?
      return
    end
    RMeetup::Client.api_key = AppConfig['meetup_api_key']
    query = query.sub(/^https?\:\/\//, '').sub(/\/+$/,'') # Remove http:// and trailing slashes
    if !!(query =~ /^[-+]?[0-9]+$/) # If the query is a number, it's probably a group_id
      result = RMeetup::Client.fetch( :groups,{ :group_id => query }).first
    elsif query.include?("meetup.com")
      uri = URI::parse("http://" + query).path.sub(/\/*/,"").sub(/\/+$/,'') # Setup string for use as group_urlname
      result = RMeetup::Client.fetch( :groups,{ :group_urlname => uri }).first
    else
      result = RMeetup::Client.fetch( :groups,{ :domain => query }).first
    end

    unless result.blank?
      meetup.name = result.name unless !meetup.name.blank?
      meetup.description = result.description
      meetup.meetup_id = result.id
      meetup.organizer_id = result.organizer["member_id"]
      meetup.meetup_link = result.link
      meetup.city = result.city
      meetup.country = result.country
      meetup.state = result.state
      meetup.latitude = result.lat
      meetup.longitude = result.lon
      unless result.group_photo.blank?
        meetup.highres_photo_url = result.group_photo["highres_link"]
        meetup.photo_url = result.group_photo["photo_link"]
        meetup.thumbnail_url = result.group_photo["thumb_link"]
      end
      meetup.join_mode = result.join_mode
      meetup.visibility = result.visibility
    end
    return meetup
  end

end