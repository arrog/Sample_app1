class ChangeColumnNote < ActiveRecord::Migration
  def up
    rename_column :notes, :integer, :valeur
    change_column :notes, :valeur,  :integer
  end

  def down
  end
end
