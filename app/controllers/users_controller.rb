class UsersController < ApplicationController

  def index
    @users = User.all.to_gmaps4rails
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:weekly] == '1'
      puts "weekly"
    elsif params[:monthly] == '1'
      puts "monthly"
    else
      puts "never"
    end
    redirect_to user_path(params[:id])
  end

end