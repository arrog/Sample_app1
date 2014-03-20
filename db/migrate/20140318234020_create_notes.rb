class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :user_id
      t.string :integer
      t.string :participation_id
      t.string :integer

      t.timestamps
    end
  end
end
