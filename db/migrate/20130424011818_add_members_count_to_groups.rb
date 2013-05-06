class AddMembersCountToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :members_count, :integer
  end
end
