class Group < ActiveRecord::Base

  belongs_to :user

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable :address => "address"

  scope :approved, where(:approval => true)

  def address
    [city, state, country].compact.join(', ')
  end

end