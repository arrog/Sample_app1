class DropReactionsTable < ActiveRecord::Migration
  def up
      drop_table :reactions
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
end
