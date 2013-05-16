class CreateJudgments < ActiveRecord::Migration
  def change
    create_table :judgments do |t|
      t.integer :user_id
      t.integer :performance_id
      t.integer :grade
      t.string :title
      t.text :content

      t.timestamps
    end
    
    add_index :judgments, [:user_id, :performance_id], unique: true
    
  end
end
