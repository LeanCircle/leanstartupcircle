class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_location

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url(:subdomain => false), :alert => exception.message
  end

  def find_location
    @location = request.location
    @location = Geocoder.search("San Francisco").first if Rails.env.development? || @location.blank?
    @nearest_meetups = Meetup.near(@location.coordinates, 50)
  end

end
