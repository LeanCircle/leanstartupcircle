class Admin::BaseController < ApplicationController

  before_filter :do_not_track

  private

  def do_not_track
    session[:do_not_track] = true
  end

end