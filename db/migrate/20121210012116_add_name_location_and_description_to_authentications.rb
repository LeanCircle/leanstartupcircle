class AddNameLocationAndDescriptionToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :name, :string
    add_column :authentications, :location, :string
    add_column :authentications, :description, :string
  end
end