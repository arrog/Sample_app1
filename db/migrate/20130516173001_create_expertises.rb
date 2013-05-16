class CreateExpertises < ActiveRecord::Migration
  def change
    create_table :expertises do |t|
      t.integer :user_id
      t.integer :doulin_id
      t.integer :position

      t.timestamps
    end
  end
end
