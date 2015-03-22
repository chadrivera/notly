class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :subscriber_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
