class AddLikesCountToJots < ActiveRecord::Migration
  def change
    add_column :jots, :likes_count, :integer
  end
end
