class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
