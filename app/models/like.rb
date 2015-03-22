class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :jot, counter_cache: true
end
