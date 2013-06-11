class AddAuthenticationIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :authentication_id, :integer
  end
end
