class AddEmailAndZipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :zipcode, :string
  end
end
