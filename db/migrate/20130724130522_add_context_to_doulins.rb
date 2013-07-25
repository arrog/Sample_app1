class AddContextToDoulins < ActiveRecord::Migration
  def change
    add_column :doulins, :content, :text
  end
end
