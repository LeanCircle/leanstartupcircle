class ChangeColumnNamesInMeetups < ActiveRecord::Migration
  def change
    rename_column :meetups, :lat, :latitude
    rename_column :meetups, :lon, :longitude
  end
end
