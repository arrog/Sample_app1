class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :judgments, :performance_id, :challenge_id
  end

  def down
  end
end
