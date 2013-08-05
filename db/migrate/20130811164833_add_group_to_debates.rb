class AddGroupToDebates < ActiveRecord::Migration
  def change
    add_column :debates, :group, :integer
  end
end
