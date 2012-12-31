class AddImageUrlDescriptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :main_url, :string
    add_column :users, :main_description, :string
    add_column :users, :main_image, :string
  end
end
