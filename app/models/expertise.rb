class Expertise < ActiveRecord::Base
  attr_accessible :doulin_id, :position, :user_id
  
  belongs_to :user
  belongs_to :doulin
  
  validates :user_id, presence: true
  #validates :doulin_id, presence: true
  validates :position, presence: true
  
  
  
  
end
