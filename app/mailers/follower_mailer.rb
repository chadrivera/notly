class FollowerMailer < ApplicationMailer

  def new_follower(follower)
    @followed_by_user = follower.user
    @following_user = follower.subscriber
    mail(to: @followed_by_user.email , subject: "You have a new follower", from: 'no-reply@notly.no')
  end


end
