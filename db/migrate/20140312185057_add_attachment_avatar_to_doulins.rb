class AddAttachmentAvatarToDoulins < ActiveRecord::Migration
  def self.up
    change_table :doulins do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :doulins, :avatar
  end
end
