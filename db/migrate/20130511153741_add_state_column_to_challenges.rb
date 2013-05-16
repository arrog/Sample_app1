class AddStateColumnToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :state, :string
  end
end
