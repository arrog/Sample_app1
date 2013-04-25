class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :title
      t.string :content
      t.string :type

      t.timestamps
    end
  end
end
