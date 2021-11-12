class Api::SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create]

  def create
    user = login(params[:email], params[:password])
    if user
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def destroy
    logout
    redirect_to root_path, success: (t '.success')
  end
end
