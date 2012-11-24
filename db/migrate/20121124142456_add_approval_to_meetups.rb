class AddApprovalToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :approval, :boolean, :default => false
  end
end
