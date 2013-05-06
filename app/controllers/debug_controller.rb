require 'pp'
class DebugController < ApplicationController
  def index
  end

  def signmein
    @user = User.find_by_email 'bkerley@brycekerley.net'
    pp @user
    sign_in :user, @user, bypass: true
    redirect_to action: 'index'
  end
end
