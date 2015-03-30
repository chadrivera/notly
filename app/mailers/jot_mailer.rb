class JotMailer < ApplicationMailer
  def send_jot_to_followers(jot)
    @jot = jot
    jot.user.followers.each do |follower|
      mail(to: follower.subscriber.email, subject: "New jot!",from: 'no-reply@notly.no')
    end

  end
end
