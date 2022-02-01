class Api::SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create]
  skip_before_action :verify_authenticity_token

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      token = user.create_tokens

      render json: { token: token }
    else
      head :unautorized
    end
  end
end
