class AddUserIdToJots < ActiveRecord::Migration
  def change
    add_column :jots, :user_id, :integer
  end
end
