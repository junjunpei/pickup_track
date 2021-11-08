class UserSessionsController < ApplicationController
  # skip_before_action :require_login, only: %i[new create]

  def new
    redirect_to root_path, info: (t 'defaults.message.already_logged_in') if logged_in?
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: (t '.success')
    else
      flash.now[:danger] = (t '.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: (t '.success')
  end
end
