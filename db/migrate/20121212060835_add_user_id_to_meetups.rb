class AddUserIdToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :user_id, :integer
  end
end
