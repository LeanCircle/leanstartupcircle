class LandingPagesController < ApplicationController

  after_filter :stash_last_url

  def thanks
  end

end
