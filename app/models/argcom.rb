class Argcom < ActiveRecord::Base 
  attr_accessible :content, :argument_id
  
  belongs_to :user
  belongs_to :argument
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :argument_id, presence: true
end
