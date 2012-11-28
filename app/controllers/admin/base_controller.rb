class Admin::BaseController < ApplicationController

  before_filter :do_not_track, :verify_admin

  # TODO: Cancan not able to authorize "Base" because not a resource. Error "uninitialized constant Base"

  private

  def do_not_track
    session[:do_not_track] = true
  end

  def verify_admin
    #raise CanCan::AccessDenied unless current_user.try(:role) == "admin"
  end

end