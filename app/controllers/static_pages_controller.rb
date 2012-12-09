class StaticPagesController < ApplicationController

  after_filter :stash_last_url

end
