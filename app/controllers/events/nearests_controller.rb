class Events::NearestsController < ApplicationController
  def show
    @events = Event.near(
      [params[:lat], params[:lng]],
      params[:radius],
      units: :km
    )
  end
end
