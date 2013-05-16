class AddGradeTwoColumnToUsers < ActiveRecord::Migration
  def change
    add_column :judgments, :grade_two, :integer
    add_column :judgments, :grade_three, :integer
    add_column :judgments, :grade_four, :integer
  end
end
