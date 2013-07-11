class AddAvatarToDebates < ActiveRecord::Migration
  def self.up
    change_table :debates do |t|
      t.has_attached_file :avatar
    end
    change_table :challenges do |t|
      t.has_attached_file :avatar
    end
    change_table :doulins do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
  end
  
end
