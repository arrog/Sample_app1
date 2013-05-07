class DropPerformancesTable < ActiveRecord::Migration
  def up
    drop_table :performances
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
