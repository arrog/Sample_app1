class AddAttachmentAvatarToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.has_attached_file :avatar
    end
  end


  def self.down
  end
end