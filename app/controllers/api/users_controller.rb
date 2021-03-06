class Api::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create registered? me update]
  skip_before_action :verify_authenticity_token
  before_action :authenticate!, only: %i[me update]

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def registered?
    user = User.find_by(email: params[:email])
    if user
      render json: user
    else
      render json: false
    end
  end

  def me
    render json: current_user
  end

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy!
    # render json: user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
