class DropChallengesTable < ActiveRecord::Migration
  def up
      drop_table :challenges
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
end
