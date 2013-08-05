class AddGroupToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :group, :integer
  end
end
