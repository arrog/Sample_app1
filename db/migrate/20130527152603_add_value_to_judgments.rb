class AddValueToJudgments < ActiveRecord::Migration
  def change
    add_column :judgments, :value, :integer
  end
end
