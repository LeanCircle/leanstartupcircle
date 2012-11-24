class CreateGroups < ActiveRecord::Migration
  def change
    create_table(:groups) do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :facebook_link
      t.string :twitter_link
      t.string :home_link
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state
      t.string :country
      t.boolean :approval
      t.boolean :gmaps

      t.timestamps
    end
  end
end
