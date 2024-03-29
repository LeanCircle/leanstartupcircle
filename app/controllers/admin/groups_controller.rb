class Admin::GroupsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @groups = Group.order("lsc DESC", "approval DESC", "country ASC")
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    if params[:group][:meetup_identifier].blank?
      @group = Group.new(params[:group])
    else
      @group = Group.fetch_from_meetup(params[:group][:meetup_identifier])
    end

    if @group.save
      flash[:success] = 'Awesome! You\'ve added a new group for everyone.'
      session[:user_return_to] ? redirect_to(session[:user_return_to]) : redirect_to(admin_groups_path)
    else
      render :action => "new"
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = 'Cool... You\'ve updated the group.'
      session[:user_return_to] ? redirect_to(session[:user_return_to]) : redirect_to(admin_group_path(@group))
    else
      render :action => "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = 'The group was destroyed! Yeargh!!! Don\'t you feel mighty?'
    redirect_to :action => 'index'
  end

end