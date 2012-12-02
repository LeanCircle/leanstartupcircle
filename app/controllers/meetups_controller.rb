class MeetupsController < ApplicationController

  def index
    @meetups = Meetup.approved
    @meetups_map = Meetup.approved.to_gmaps4rails
  end

  def show
    @meetup = Meetup.find(params[:id])
  end

  def new
    @meetup = Meetup.new
  end

  def create
    if params[:commit].eql?('Cancel')
      redirect_to root_url
    else
      @meetup = Meetup.new(params[:meetup])
      @meetup = Meetup.fetch_from_meetup(@meetup, params[:meetup][:meetup_identifier])
      if @meetup.save
        flash[:success] = "Awesome...hang tight! We have to make sure it's a lean startup group."
        redirect_to meetups_path
      else
        render :action => "new"
      end
    end
  end

end