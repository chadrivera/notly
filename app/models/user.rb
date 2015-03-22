class User < ActiveRecord::Base
  has_many :jots
  has_many :likes

  has_many :followers
  has_many :subscribers, through: :followers

  #we really want to get the jots of the followers
  has_many :subscriptions, class_name: 'Follower', foreign_key: 'subscriber_id'

  validates_presence_of :email, uniqueness: true
  validates_presence_of :displayname, uniqueness: :true

  def following_jots
    Jot.joins(:user => :subscriptions).where('followers.user_id =?', id)
  end

end
