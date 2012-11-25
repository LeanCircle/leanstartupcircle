class AddGoogleplusLinkToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :googleplus_link, :string
  end
end
