class CreateRepliques < ActiveRecord::Migration
  def change
    create_table :repliques do |t|
      t.integer :user_id
      t.belongs_to :replicable, polymorphic: true
      t.timestamps
    end
    add_index :repliques, [:replicable_id, :replicable_type]
  end
end
