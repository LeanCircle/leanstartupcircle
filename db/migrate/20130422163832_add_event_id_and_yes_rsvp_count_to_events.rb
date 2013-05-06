class AddEventIdAndYesRsvpCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_id, :integer
    add_column :events, :yes_rsvp_count, :integer
  end
end
