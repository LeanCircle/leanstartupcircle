class MeetupsController < ApplicationController

  def index
    @meetups = Meetup.approved.to_gmaps4rails do |meetup, marker|
      marker.infowindow render_to_string(:partial => "/meetups/gmap_info_window", :locals => { :meetup => meetup})
      marker.sidebar render_to_string(:partial => "/meetups/meetup_list_item", :locals => { :meetup => meetup})
    end
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
      @meetup = Meetup.fetch_from_meetup(params[:meetup][:meetup_identifier], @meetup) if !params[:meetup][:meetup_identifier].blank?
      if @meetup.save
        flash[:success] = "Awesome...hang tight! We have to make sure it's a lean startup group."
        redirect_to meetups_path
      else
        render :action => "new"
      end
    end
  end

end