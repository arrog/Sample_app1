class AddCatIdColumnToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :cat_id, :integer
    add_column :debates, :cat_id, :integer
    add_column :doulins, :cat_id, :integer
  end
end
