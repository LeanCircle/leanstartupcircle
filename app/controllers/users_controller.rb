class UsersController < ApplicationController

  def index
    @users = User.all.to_gmaps4rails
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    puts params[:frequency]
    redirect_to user_path(params[:id])
  end

end