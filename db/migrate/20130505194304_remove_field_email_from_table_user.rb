class RemoveFieldEmailFromTableUser < ActiveRecord::Migration
  def up
    remove_column :users, :email
    remove_column :users, :password
    remove_column :users, :password_confirmation
  end

  def down
  end
end
