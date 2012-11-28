class Admin::UsersController < Admin::BaseController
  #load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'Awesome! You\'ve added a new user for everyone.'
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'Cool... You\'ve updated the user.'
      redirect_to admin_user_path(@user)
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = 'The user was destroyed! Yeargh!!! Don\'t you feel mighty?'
    redirect_to :action => 'index'
  end

  def imitate
    flash[:alert] = "Imitate not working!!"
    #session[:user_id] = User.find(params[:user_id])
    #flash[:alert] = "You're now logged in as " + current_user.name + "! BE CAREFUL!"
    redirect_to root_path
  end

end