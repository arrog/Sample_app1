class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :type
      t.string :title
      t.text :context

      t.timestamps
    end
  end
end
