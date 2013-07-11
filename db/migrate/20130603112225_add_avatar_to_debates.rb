class AddAvatarToDebates < ActiveRecord::Migration
  def self.up
    change_table :debates do |t|
      t.attachment :avatar
    end
    change_table :challenges do |t|
      t.attachment :avatar
    end
    change_table :doulins do |t|
      t.attachment :avatar
    end
  end

  def self.down
  end
  
end
