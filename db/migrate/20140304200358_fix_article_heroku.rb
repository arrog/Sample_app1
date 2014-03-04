class FixArticleHeroku < ActiveRecord::Migration
  def change
    rename_column :debates, :article_id, :article_id_string
    add_column :debates, :article_id, :integer
    remove_column :contacts, :article_id_string
  end
end
