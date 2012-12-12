class ChangeMeetupsTableToGroupsTable < ActiveRecord::Migration
  def change
    rename_table :meetups, :groups
  end
end
