class Api::TracksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_bearer_token, only: %i[search my_library recommend audio_features]
  before_action :authenticate!
  before_action :set_track, only: %i[destroy recommend]
  before_action :audio_features, only: :recommend
  require 'net/http'
  require 'uri'

  def search
    uri = URI.parse(ENV['SEARCH_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = { 'Authorization' => "Bearer #{@bearer_token}", 'Accept-Language' => 'ja' }
    uri.query = URI.encode_www_form({ q: params[:search], type: 'track', limit: '50', market: 'JP' })
    response = http.get(uri.request_uri, header)
    response_body = JSON.parse(response.body)
    tracks = response_body['tracks']['items']
    render json: tracks
  end

  def recommend
    uri = URI.parse(ENV['RECOMMEND_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = { 'Authorization' => "Bearer #{@bearer_token}", 'Accept-Language' => 'ja' }
    uri.query = URI.encode_www_form({ seed_artists: @track.artist_id, seed_genres: 'genres', seed_tracks: @track.track_id, limit: 10, market: 'JP', target_acousticness: @audio_features['acousticness'], target_danceability: @audio_features['danceability'], target_duration_ms: @audio_features['duration_ms'], target_energy: @audio_features['energy'], target_instrumentalness: @audio_features['instrumentalness'], target_key: @audio_features['key'], target_liveness: @audio_features['liveness'], target_loudness: @audio_features['loudness'], target_mode: @audio_features['mode'], target_speechiness: @audio_features['speechiness'], target_tempo: @audio_features['tempo'], target_time_signature: @audio_features['time_signature'], target_valence: @audio_features['valence'] })
    response = http.get(uri.request_uri, header)
    response_body = JSON.parse(response.body)
    tracks = response_body['tracks']
    render json: tracks
  end

  def index
    @my_tracks = current_user.tracks.all.order(:id)
    render json: @my_tracks
  end

  def create
    track = current_user.tracks.build(track_params)

    if track.save
      render json: track
    else
      render json: track.errors, status: :bad_request
    end
  end

  def destroy
    @track.destroy!
    render json: @track
  end

  private

  def set_bearer_token
    uri = URI.parse(ENV['TOKEN_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    encode = Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_SECRET_ID']}")
    header = { 'Authorization' => "Basic #{encode}" }
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = 'grant_type=client_credentials'
    response = http.request(request)
    response_body = JSON.parse(response.body)
    @bearer_token = response_body['access_token']
  end

  def set_track
    @track = current_user.tracks.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:track_id, :artist_id, :name, :artist_name, :album_name, :image_url, :track_url)
  end

  def audio_features
    uri = URI.parse(ENV['AUDIO_FEATURES_URL'] + '/' + @track.track_id)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = { 'Authorization' => "Bearer #{@bearer_token}", 'Accept-Language' => 'ja' }
    response = http.get(uri.request_uri, header)
    @audio_features = JSON.parse(response.body)
  end
end
