class EventsController < ApplicationController

  def index
    @events = Event.upcoming_week
  end

  def show
    @event = Event.find(params[:id])
  end

end