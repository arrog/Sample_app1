class Judgment < ActiveRecord::Base
  attr_accessible :content, :grade, :challenge_id, :title, :user_id,  :grade_two,  :grade_three,  :grade_four
  
  belongs_to :user
  belongs_to :challenge
  
  validates :user_id, presence: true
  validates :challenge_id, presence: true
  validates :title, presence: true
  
end
