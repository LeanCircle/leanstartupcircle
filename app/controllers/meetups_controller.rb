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

  def create
    @meetup = Meetup.fetch_from_meetup(Meetup.new, params[:meetup][:meetup_id])
    if @meetup.save
      flash[:success] = 'Awesome! You\'ve added a new meetup for everyone.'
      redirect_to meetups_path
    else
      render :action => "new"
    end
  end

end