class FixColumnType < ActiveRecord::Migration
  def up
    rename_column :Challenges, :type, :type_deb
  end

  def down
  end
end
