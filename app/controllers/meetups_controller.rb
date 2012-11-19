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
    RMeetup::Client.api_key = "4404a5c4f33d2771b2d67175c2772 "
    result = RMeetup::Client.fetch( :groups,{ :group_id => params[:meetup][:meetup_id] }).first
    @meetup = Meetup.new( :name => result.name,
                          :description => result.description,
                          :meetup_id => result.id,
                          :organizer_id => result.organizer[:member_id],
                          :link => result.link,
                          :city => result.city,
                          :country => result.country,
                          :state => result.state,
                          :lat => result.lat,
                          :lon => result.lon,
                          :highres_photo_url => result.group_photo[:highres_link],
                          :photo_url => result.group_photo[:photo_link],
                          :thumbnail_url => result.group_photo[:thumb_link],
                          :join_mode => result.join_mode,
                          :visibility => result.visibility)

    if @meetup.save
      flash[:success] = 'Awesome! You\'ve added a new meetup for everyone.'
      redirect_to meetups_path
    else
      render :action => "new"
    end
  end

  def update
    @meetup = Meetup.find(params[:id])
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
end