class AddContentToRepliques < ActiveRecord::Migration
  def change
    add_column :repliques, :content, :string
  end
end
