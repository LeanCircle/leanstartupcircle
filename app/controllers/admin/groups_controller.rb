class Admin::GroupsController < Admin::BaseController

  def index
    @groups = Group.all
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
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = 'Awesome! You\'ve added a new group for everyone.'
      redirect_to admin_groups_path
    else
      render :action => "new"
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = 'Cool... You\'ve updated the group.'
      redirect_to admin_group_path(@group)
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