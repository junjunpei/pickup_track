class TracksController < ApplicationController
  def index
    if params[:search].present?
      @tracks = RSpotify::Track.search(params[:search])
    end
  end
end
