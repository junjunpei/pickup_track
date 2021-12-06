class Api::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create registered? me update]
  skip_before_action :verify_authenticity_token
  before_action :authenticate!, only: %i[me update]

  # def new
  #   return redirect_to root_path, info: (t 'defaults.message.already_logged_in') if logged_in?
  #   @user = User.new
  # end

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

  # def show
  #   @user = User.find(params[:id])
  # end

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  # def destroy
  #   if params[:check] == '1'
  #     User.find(params[:id]).destroy
  #     redirect_to new_user_path, success: (t '.success')
  #   else
  #     flash.now[:danger] = (t '.fail')
  #     render :delete
  #   end
  # end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
