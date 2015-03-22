class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user.present?
      session[:current_user_id] = user.id
      redirect_to jots_path, notice: "You're signed in"
    else
      flash[:warning] = "No user with that name"
      redirect_to new_session_path
    end

  end

  def destroy
  end


end
