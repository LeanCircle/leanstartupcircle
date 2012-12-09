class AddCountryCodeToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :country_code, :string
  end
end
