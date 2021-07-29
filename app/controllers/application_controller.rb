class ApplicationController < ActionController::Base
  
  before_action :require_login

  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  private
  
  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end
end
