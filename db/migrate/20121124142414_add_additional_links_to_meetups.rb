class AddAdditionalLinksToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :facebook_link, :string
    add_column :meetups, :twitter_link, :string
    add_column :meetups, :linkedin_link, :string
    add_column :meetups, :home_link, :string
    rename_column :meetups, :link, :meetup_link
  end
end
