class CreateModerations < ActiveRecord::Migration[5.1]
  def change
    create_table :moderations do |t|
      t.integer :moderator_id, null: false
      t.integer :sub_id, null: false
      t.timestamps
    end
      add_index :moderations, [:moderator_id, :sub_id ], unique: true
  end
end
