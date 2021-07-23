class TracksController < ApplicationController
  def index
    @q = RSpotify::Track.ransack(params[:q])
    @tracks = @q.result
  end
end
