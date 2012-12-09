class AddLscColumnToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :lsc, :boolean, :default => false
  end
end
