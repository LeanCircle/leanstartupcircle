class MeetupsController < ApplicationController

  def index
    @meetups = Meetup.all
  end

  def show
    @meetup = Meetup.find(params[:id])
  end

  def new
    @meetup = Meetup.new
  end

  def edit
    @meetup = Meetup.find(params[:id])
  end

  def create
    @meetup = Meetup.new
    fetch_from_meetup(params[:meetup][:meetup_id])
    if @meetup.save
      flash[:success] = 'Awesome! You\'ve added a new meetup for everyone.'
      redirect_to meetups_path
    else
      render :action => "new"
    end
  end

  def update
    @meetup = Meetup.find(params[:id])
    fetch_from_meetup(@meetup.meetup_id)
    if @meetup.update_attributes(params[:meetup])
      flash[:success] = 'Cool... You\'ve updated the meetup.'
      redirect_to meetup_path(@meetup)
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

  private

  def fetch_from_meetup(meetup_id)
    RMeetup::Client.api_key = AppConfig['meetup_api_key']
    result = RMeetup::Client.fetch( :groups,{ :group_id => meetup_id }).first
    @meetup.name = result.name
    @meetup.description = result.description
    @meetup.meetup_id = result.id
    @meetup.organizer_id = result.organizer["member_id"]
    @meetup.link = result.link
    @meetup.city = result.city
    @meetup.country = result.country
    @meetup.state = result.state
    @meetup.lat = result.lat
    @meetup.lon = result.lon
    @meetup.highres_photo_url = result.group_photo["highres_link"]
    @meetup.photo_url = result.group_photo["photo_link"]
    @meetup.thumbnail_url = result.group_photo["thumb_link"]
    @meetup.join_mode = result.join_mode
    @meetup.visibility = result.visibility
  end

end