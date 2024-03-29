class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_location
  after_filter :stash_last_url, :only => [:index, :show]

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to session[:user_return_to], :alert => "Oops... " + exception.message
    else
      redirect_to :sign_in, :alert => "Oops... you need to sign in first!"
    end

  end

  def find_location
    @location = request.location
    @location = Geocoder.search("San Francisco").first if !Rails.env.production? || @location.blank?
    @nearest_groups = Group.near(@location.coordinates, 50).approved
  end

  def stash_last_url
    session[:user_return_to] = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

end
