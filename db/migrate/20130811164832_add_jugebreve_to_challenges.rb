class AddJugebreveToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :jugebreve, :integer
  end
end
