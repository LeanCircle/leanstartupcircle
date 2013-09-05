class LandingPagesController < ApplicationController

  after_filter :stash_last_url

  def index
    @user = User.new
  end

end
