class UsersController < ApplicationController
  before_action :require_login
  layout "footer", except: [:new]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])
    @user.update(user_params)
  
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit(:email, :avatar, :remove_avatar)
  end
end
