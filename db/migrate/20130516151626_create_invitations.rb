class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :challenge_id
      t.integer :position

      t.timestamps
    end
  end
end
