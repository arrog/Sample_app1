class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :value

      t.timestamps
    end
    add_index :relationships, :sender_id
    add_index :relationships, :reciever_id
    add_index :relationships, [:sender_id, :reciever_id]
  end
end
