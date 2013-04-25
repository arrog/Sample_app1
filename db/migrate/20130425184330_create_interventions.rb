class CreateInterventions < ActiveRecord::Migration
  def change
    create_table :interventions do |t|
      t.string :title
      t.string :content
      t.integer :performance_id

      t.timestamps
    end
    
    add_index :interventions, :performance_id
  end
end
