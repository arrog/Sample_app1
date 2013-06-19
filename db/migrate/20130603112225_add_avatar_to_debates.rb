class AddAvatarToDebates < ActiveRecord::Migration
  def self.up
    add_attachment :debates, :avatar
    add_attachment :challenges, :avatar
    add_attachment :doulins, :avatar
  end

  def self.down
  end
  
end
