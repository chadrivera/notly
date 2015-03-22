# Preview all emails at http://localhost:3000/rails/mailers/follower_mailer
class FollowerMailerPreview < ActionMailer::Preview
  def new_follower
    @following = User.new(email: 'following@example.com', displayname: 'F.ex')
    @followed_by = User.new(email: 'follwed@example.com', displayname: 'Fd.ex')

    @follower = Follower.new
    @follower.subscriber = @following
    @follower.user = @followed_by
    FollowerMailer.new_follower(@follower)
  end

end
