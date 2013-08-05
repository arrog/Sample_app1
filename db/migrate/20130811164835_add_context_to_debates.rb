class AddContextToDebates < ActiveRecord::Migration
  def change
    add_column :debates, :context, :text
  end
end
