class Meetup < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude

  def self.fetch_from_meetup(meetup, meetup_id)
    RMeetup::Client.api_key = AppConfig['meetup_api_key']
    result = RMeetup::Client.fetch( :groups,{ :group_id => meetup_id }).first
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
