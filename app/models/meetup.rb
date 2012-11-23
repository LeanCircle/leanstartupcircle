class Meetup < ActiveRecord::Base
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable :address => "address"

  def address
    [city, state, country].compact.join(', ')
  end

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.city}, #{self.state}, #{self.country}"
  end

  def self.fetch_from_meetup(meetup, query)
    RMeetup::Client.api_key = AppConfig['meetup_api_key']

    if !!(query =~ /^[-+]?[0-9]+$/)
      result = RMeetup::Client.fetch( :groups,{ :group_id => query }).first
    else
      result = RMeetup::Client.fetch( :groups,{ :domain => query }).first
    end

    meetup.name = result.name
    meetup.description = result.description
    meetup.meetup_id = result.id
    meetup.organizer_id = result.organizer["member_id"]
    meetup.link = result.link
    meetup.city = result.city
    meetup.country = result.country
    meetup.state = result.state
    meetup.latitude = result.lat
    meetup.longitude = result.lon
    meetup.highres_photo_url = result.group_photo["highres_link"]
    meetup.photo_url = result.group_photo["photo_link"]
    meetup.thumbnail_url = result.group_photo["thumb_link"]
    meetup.join_mode = result.join_mode
    meetup.visibility = result.visibility
    return meetup
  end

end