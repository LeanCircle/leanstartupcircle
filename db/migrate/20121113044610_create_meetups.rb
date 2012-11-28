class CreateMeetups < ActiveRecord::Migration
  def change
    create_table(:meetups) do |t|
      t.string :name
      t.text :description
      t.integer :meetup_id
      t.integer :organizer_id
      t.string :facebook_link
      t.string :twitter_link
      t.string :linkedin_link
      t.string :googleplus_link
      t.string :home_link
      t.string :meetup_link

      t.string :city
      t.string :country
      t.string :state
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.string :highres_photo_url
      t.string :photo_url
      t.string :thumbnail_url

      t.string :join_mode
      t.string :visibility

      t.boolean :approval, :default => false # For authorized meetups only

      t.string :slug # For friendly_id

      t.timestamps
    end

    add_index :meetups, :slug, unique: true

  end
end