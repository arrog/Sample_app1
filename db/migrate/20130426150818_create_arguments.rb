class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.integer :user_id
      t.text :content
      t.text :title
      t.belongs_to :argumentable, polymorphic: true
      
      t.timestamps
    end
    add_index :arguments, [:argumentable_id, :argumentable_type]
  end
end
