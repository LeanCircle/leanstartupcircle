class AddApprovedColumnToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :approval, :boolean, :default => 0
  end
end
