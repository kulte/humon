class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.create!(event_params)
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes(event_params)
  end

  private

  def event_params
    params.permit(:address, :ended_at, :lat, :lng, :name, :started_at)
      .merge(owner_id: current_user.id)
  end
end
