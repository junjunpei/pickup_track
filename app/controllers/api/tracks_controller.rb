class Api::TracksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_bearer_token
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
end
