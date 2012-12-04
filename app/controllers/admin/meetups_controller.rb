class Admin::MeetupsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @meetups = Meetup.all
  end

  def show
    @meetup = Meetup.find(params[:id])
  end

  def new
    authorize! :create, Meetup
    @meetup = Meetup.new
  end

  def edit
    @meetup = Meetup.find(params[:id])
  end

  def create
    authorize! :create, @meetup
    @meetup = Meetup.fetch_from_meetup(params[:meetup][:meetup_id])
    if @meetup.save
      flash[:success] = 'Awesome! You\'ve added a new meetup for everyone.'
      redirect_to admin_meetups_path
    else
      render :action => "new"
    end
  end

  def update
    @meetup = Meetup.find(params[:id])
    if @meetup.update_attributes(params[:meetup])
      flash[:success] = 'Cool... You\'ve updated the meetup.'
      redirect_to admin_meetup_path(@meetup)
    else
      render :action => "edit"
    end
  end

  def destroy
    @meetup = Meetup.find(params[:id])
    @meetup.destroy
    flash[:alert] = 'The meetup was destroyed! Yeargh!!! Don\'t you feel mighty?'
    redirect_to :action => 'index'
  end

end