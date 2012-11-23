class AddApprovedColumnToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :approve, :boolean, :default => 0
  end
end
