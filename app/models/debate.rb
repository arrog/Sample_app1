class Debate < ActiveRecord::Base
  attr_accessible :content, :title, :type_of_debate
  
  has_many :performances, foreign_key: "debate_id", dependent: :destroy
  has_many :users, through: :performances
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  validates :type_of_debate, presence: true
  
  def particpate!(user)
    performances.create!(user_id: user.id)
  end
  
  def leave_debate!(user)
    performances.find_by_user_id(user.id).destroy
  end
  
end
