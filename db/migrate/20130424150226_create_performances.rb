class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :user_id
      t.integer :debate_id
      t.string :position
      t.integer :rating

      t.timestamps
    end
    add_index :performances, :user_id
    add_index :performances, :debate_id
    add_index :performances, [:user_id, :debate_id], unique: true
  end
end
