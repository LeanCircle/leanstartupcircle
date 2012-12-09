class ChangeStateToProvinceInMeetups < ActiveRecord::Migration
  def change
    rename_column :meetups, :state, :province
    rename_column :users, :state, :province
  end
end
