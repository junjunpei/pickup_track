class Api::HistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate!
  before_action :set_history_track, only: :destroy

  def index
    @history_tracks = current_user.histories.all.order(id: :desc)
    render json: @history_tracks
  end

  def times
    @history_tracks_times = current_user.histories.group(:track_id, :name, :artist_name, :album_name, :image_url).order('count(track_id) desc').count.to_a
    render json: @history_tracks_times
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
    @history_track.destroy!
    render json: @history_track
  end

  private

  def history_params
    params.require(:history).permit(:track_id, :artist_id, :name, :artist_name, :album_name, :image_url, :track_url)
  end

  def set_history_track
    @history_track = current_user.histories.find(params[:id])
  end
end
