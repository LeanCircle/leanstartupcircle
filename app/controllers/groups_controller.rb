class GroupsController < ApplicationController

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
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    if params[:commit].eql?('Cancel')
      redirect_to root_url
    else
      @group = Group.new(params[:group])
      @group = Group.fetch_from_meetup(params[:group][:group_identifier], @group) if !params[:group][:meetup_identifier].blank?
      if @group.save
        flash[:success] = "Awesome...hang tight! We have to make sure it's a lean startup group."
        redirect_to groups_path
      else
        render :action => "new"
      end
    end
  end

end