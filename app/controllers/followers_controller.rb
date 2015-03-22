class FollowersController < ApplicationController

  def create

    follower = Follower.create(subscriber_id: current_user.id,
                                user_id: params[:user_id])
    FollowerMailer.new_follower(follower).deliver_later
    redirect_to jots_path
  end

  def destroy
    @follower = Follower.find_by_user_id_and_subscriber_id(params[:user_id], current_user.id)
    @follower.delete
    redirect_to jots_path
  end


end
