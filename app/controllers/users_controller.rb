class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    return redirect_to root_path, info: (t 'defaults.message.already_logged_in') if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: (t '.success')
    else
      flash.now[:danger] = (t '.fail')
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, success: (t '.success')
    else
      flash.now[:danger] = (t '.fail')
      render edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to new_user_path, success: (t '.destroy')
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
