class FixDebateIdName < ActiveRecord::Migration
  def change
     rename_column :debates, :type_of_debate, :article_id
   end
end
