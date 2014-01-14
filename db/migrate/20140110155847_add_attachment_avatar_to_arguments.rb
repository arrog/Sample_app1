class AddAttachmentAvatarToArguments < ActiveRecord::Migration
  def self.up
    change_table :arguments do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :arguments, :avatar
  end
end
