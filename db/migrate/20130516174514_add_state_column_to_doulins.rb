class AddStateColumnToDoulins < ActiveRecord::Migration
  def change
    add_column :doulins, :state, :string
  end
end
