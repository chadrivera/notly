class CreateJots < ActiveRecord::Migration
  def change
    create_table :jots do |t|
      t.text :text

      t.timestamps null: false
    end
  end
end
