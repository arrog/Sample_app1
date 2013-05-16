class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.text :context
      t.text :title
      t.integer :type_deb

      t.timestamps
    end
  end
end
