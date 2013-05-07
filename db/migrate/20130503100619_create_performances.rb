class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.integer :position
      t.integer :perf

      t.timestamps
    end
    
    add_index :performances, [:user_id, :challenge_id]
  end
end
