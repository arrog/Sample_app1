class Debate < ActiveRecord::Base
  attr_accessible :content, :title, :type_of_debate
  
  has_many :arguments, as: :argumentable
  has_many :users, through: :arguments
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  validates :type_of_debate, presence: true
  
end
