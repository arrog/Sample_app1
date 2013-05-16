class AddStateColumnToDebates < ActiveRecord::Migration
  def change
    add_column :debates, :state, :text
  end
end
