class AddAttachmentAvatarToDebates < ActiveRecord::Migration
  def self.up
    change_table :debates do |t|
      t.attachment :avatar
    end
    change_table :doulins do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :debates, :avatar
    drop_attached_file :doulins, :avatar  
  end
end
