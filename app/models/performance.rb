class Performance < ActiveRecord::Base
  attr_accessible :debate_id, :position, :rating, :user_id
  
  belongs_to :user, class_name: "User"
  belongs_to :debate, class_name: "Debate"
  
  validates :user_id, presence: true
  validates :debate_id, presence: true
  
end
