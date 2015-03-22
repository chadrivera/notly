class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.email = users_params[:email]
    @user.displayname = users_params[:displayname]
    @user.save

    unless @user.errors.present?
      session[:current_user_id] = @user.id
      redirect_to jots_path
    end

  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
  end

  private
  def users_params
    params.require(:user).permit(:email,:displayname)
  end
end
