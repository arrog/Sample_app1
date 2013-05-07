class Performance < ActiveRecord::Base
  attr_accessible :challenge_id, :perf, :position, :user_id
  
  belongs_to :user
  belongs_to :challenge
  
  validates :user_id, presence: true
  validates :challenge_id, presence: true
  validates :position, presence: true
  
  
end
