class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :zipcode, :string
    add_column :users, :company_name, :string
    add_column :users, :phone, :string

    add_column :users, :role, :string # For RBAC

    add_column :users, :slug, :string # For friendly_id
    add_index :users, :slug, unique: true
  end

end
