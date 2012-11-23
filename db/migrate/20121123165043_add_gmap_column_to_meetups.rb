class AddGmapColumnToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :gmaps, :boolean
  end
end
