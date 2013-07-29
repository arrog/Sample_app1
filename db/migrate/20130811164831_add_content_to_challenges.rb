class AddContentToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :content, :text
  end
end
