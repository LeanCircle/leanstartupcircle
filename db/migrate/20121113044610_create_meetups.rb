class CreateMeetups < ActiveRecord::Migration
  def change
    create_table(:meetups) do |t|
      t.string :name
      t.text :description
      t.integer :meetup_id
      t.integer :organizer_id
      t.string :link

      t.string :city
      t.string :country
      t.string :state
      t.float :latitude
      t.float :longitude

      t.string :highres_photo_url
      t.string :photo_url
      t.string :thumbnail_url

      t.string :join_mode
      t.string :visibility

      t.timestamps
    end
  end
end