class GroupsController < ApplicationController
  load_and_authorize_resource :except => :metrics
  after_filter :stash_last_url
  def index
    @groups = Group.near(@location.coordinates, 20000).approved.to_gmaps4rails do |group, marker|
      marker.infowindow render_to_string(:partial => "/groups/gmap_info_window", :locals => { :group => group})
      marker.sidebar render_to_string(:partial => "/groups/group_list_item", :locals => { :group => group})
      if @nearest_groups.include?(group) && group.lsc
        marker.picture({ :picture => "http://maps.google.com/mapfiles/marker.png" })
      elsif @nearest_groups.include?(group)
        marker.picture({ :picture => "http://labs.google.com/ridefinder/images/mm_20_red.png" })
      elsif group.lsc
        marker.picture({ :picture => "http://maps.google.com/mapfiles/marker_orange.png" })
      else
        marker.picture({ :picture => "http://labs.google.com/ridefinder/images/mm_20_orange.png" })
      end
    end
  end

  def organizers
    @users = User.joins(:groups).uniq
  end

  def show
    @group = Group.approved.find(params[:id])
    @upcoming_events = @group.events.upcoming
    @past_events = @group.events.past
  end

  def new
    @group = Group.new
  end

  def create
    redirect_to groups_path if params[:commit].eql?('Cancel')

    if params[:group][:meetup_identifier].blank?
      @group = Group.new(params[:group])
    else
      @group = Group.fetch_from_meetup(params[:group][:meetup_identifier])
    end
    if @group.try(:save)
      if current_user.present?
        current_user.groups << session["auth"].groups unless session["auth"].groups.blank?
        flash[:success] = "Awesome...hang tight! A human will have to make sure it's a lean startup group." 
        redirect_to groups_path 
      else
        session["group_to_assign"] = @group.id
        flash[:success] = "Your group still needs to be approved. Please sign up so we can confirm your group is really about lean startup."
        redirect_to :sign_up
      end
    else
      render :action => "new"
    end
  end

  def metrics
    @groups = Group.approved
    @events_count = Event.count
    @events_lsc = Event.lsc
  end

end