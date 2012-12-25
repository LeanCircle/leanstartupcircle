class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_location
  after_filter :stash_last_url, :only => [:index, :show]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url, :alert => exception.message
  end

  def find_location
    @location = request.location
    @location = Geocoder.search("San Francisco").first if Rails.env.development? || @location.blank?
    @nearest_groups = Group.near(@location.coordinates, 50)
  end

  def stash_last_url
    session[:user_return_to] = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

end
