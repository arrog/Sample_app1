class CreateArgcoms < ActiveRecord::Migration
  def change
    create_table :argcoms do |t|
      t.integer :user_id
      t.integer :argument_id
      t.string :content

      t.timestamps
    end
    add_index :argcoms, [:user_id, :created_at]
  end
end
