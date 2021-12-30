class Api::PasswordResetsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by(email: params[:email])
    return unless @user&.deliver_reset_password_instructions!

    head :ok
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    head :not_found if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]

    @user.change_password(params[:user][:password])
  end
end
