class Admin::BaseController < ApplicationController

  before_filter :do_not_track, :verify_admin

  private

  def do_not_track
    session[:do_not_track] = true
  end

  def verify_admin
    stash_last_url
    raise CanCan::AccessDenied.new("Not authorized!", :dashboard, "") unless can? :manage, :all
  end
end