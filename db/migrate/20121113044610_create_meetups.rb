class CreateMeetups < ActiveRecord::Migration
  def change
    create_table(:meetups) do |t|
      # Identifiers
      t.integer :meetup_id
      t.integer :organizer_id

      # Basic info
      t.string :name
      t.text :description

      # Links to various group assets
      t.string :facebook_link
      t.string :twitter_link
      t.string :linkedin_link
      t.string :googleplus_link
      t.string :home_link
      t.string :meetup_link

      # For geolocation
      t.string :city
      t.string :country
      t.string :state
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      # Photo urls
      t.string :highres_photo_url
      t.string :photo_url
      t.string :thumbnail_url

      # Misc info given by meetup
      t.string :join_mode
      t.string :visibility

      # For authorized meetups only
      t.boolean :approval, :default => false

      # For friendly_id
      t.string :slug

      t.timestamps
    end

    # For friendly_id
    add_index :meetups, :slug, unique: true

  end
end