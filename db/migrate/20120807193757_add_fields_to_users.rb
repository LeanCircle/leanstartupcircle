class AddFieldsToUsers < ActiveRecord::Migration
  def change
    # Basic info
    add_column :users, :name, :string
    add_column :users, :phone, :string

    # For geolocation
    add_column :users, :zipcode, :string
    t.float :latitude
    t.float :longitude
    t.boolean :gmaps

    # For RBAC
    add_column :users, :role, :string, :default => "member"

    # For friendly_id
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end

end
