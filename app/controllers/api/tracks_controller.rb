class Api::TracksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_bearer_token, only: %i[search my_library]
  before_action :require_login
  before_action :authenticate!
  before_action :set_track, only: :destroy
  require 'net/http'
  require 'uri'

  def search
    # return unless params[:search].present?
    # result = RSpotify::Track.search(params[:search])
    # @tracks = Kaminari.paginate_array(result).page(params[:page]).per(10)
    uri = URI.parse(ENV['SEARCH_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = { 'Authorization' => "Bearer #{@bearer_token}", 'Accept-Language' => 'ja;q=1' }
    uri.query = URI.encode_www_form({ q: params[:search], type: 'track', limit: '50', offset: '0', market: 'JP' })
    response = http.get(uri.request_uri, header)
    response_body = JSON.parse(response.body)
    tracks = response_body['tracks']['items']
    render json: tracks
  end

  def my_library
    uri = URI.parse("#{ENV['TRACK_URL']}/#{params[:track_id]}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = { 'Authorization' => "Bearer #{@bearer_token}", 'Accept-Language' => 'ja;q=1' }
    uri.query = URI.encode_www_form({ market: 'JP' })
    response = http.get(uri.request_uri, header)
    my_track = JSON.parse(response.body)
    render json: my_track
  end

  def index
    @my_tracks = current_user.tracks.all.order(:id)
    render json: @my_tracks
  end

  def create
    track = current_user.tracks.build(track_id: params[:track_id])

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
end
