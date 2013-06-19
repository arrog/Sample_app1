class Judgment < ActiveRecord::Base
  attr_accessible :content, :grade, :challenge_id, :title, :grade_two,  :grade_three,  :grade_four
  
  belongs_to :user
  belongs_to :challenge
  

  validates :title, presence: true
  validates :grade, presence:true
  validates :grade_two, presence:true
  
end
