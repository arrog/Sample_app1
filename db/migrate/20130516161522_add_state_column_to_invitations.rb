class AddStateColumnToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :state, :string
  end
end
