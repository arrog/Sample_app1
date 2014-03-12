class AddDoulinIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :doulin_id, :integer
  end
end
