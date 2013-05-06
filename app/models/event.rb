class Event < ActiveRecord::Base
  belongs_to :group
  attr_accessible :location_address, :location_name, :meeting_at, :name, :group_id, :event_url, :yes_rsvp_count, :event_id
  
  delegate :name, :to => :group, :prefix => true, :allow_nil => true

  scope :upcoming, where("events.meeting_at > ?", Time.zone.now).order("meeting_at asc").includes(:group)
  scope :past, limit(5).order("meeting_at desc").where("events.meeting_at < ?", Time.zone.now).includes(:group)
  scope :upcoming_week, where("events.meeting_at BETWEEN ? AND ?", Time.zone.now, Time.zone.now + 1.week).order("meeting_at asc").includes(:group)
  scope :lsc, joins(:group).where('groups.lsc' => true)

  def meeting_date
    meeting_at.strftime("%a %b %e, %Y")
  end

  def meeting_hour
    meeting_at.strftime("%l:%M %P")
  end

end


