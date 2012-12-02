class UsersController < ApplicationController

  def index
    @users_map = User.all.to_gmaps4rails
  end

  def show
    @user = User.find(params[:id])
  end

end