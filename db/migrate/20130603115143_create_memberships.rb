class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :role

      t.timestamps
    end
    
    add_index :memberships, [:user_id, :group_id]
  end
end
