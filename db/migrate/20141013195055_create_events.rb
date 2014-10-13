class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :checkincode
      t.string :comment
      t.boolean :attendance
      t.integer :user_id

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
  end
end
