class Api::HistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate!

  def index

  end

  def create
    history_track = current_user.histories.build(history_params)

    if history_track.save
      render json: history_track
    else
      render json: history_track.errors, status: :bad_request
    end
  end

  def destroy

  end

  private

  def history_params
    params.require(:history).permit(:track_id, :artist_id, :name, :artist_name, :album_name, :image_url, :track_url)
  end
end
