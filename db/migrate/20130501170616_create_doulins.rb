class CreateDoulins < ActiveRecord::Migration
  def change
    create_table :doulins do |t|
      t.string :context
      t.string :title

      t.timestamps
    end
  end
end
