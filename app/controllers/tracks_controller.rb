class TracksController < ApplicationController
  def index
    return unless params[:search].present?

    result = RSpotify::Track.search(params[:search])
    @tracks = Kaminari.paginate_array(result).page(params[:page]).per(10)
  end
end
