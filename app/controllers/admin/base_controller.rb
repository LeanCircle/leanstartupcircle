class Admin::BaseController < ApplicationController
  load_and_authorize_resource
  before_filter :do_not_track

  private

  def do_not_track
    session[:do_not_track] = true
  end

end