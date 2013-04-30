class Debate < ActiveRecord::Base
  attr_accessible :content, :title, :type_of_debate
  
  has_many :arguments, as: :argumentable
  has_many :users, through: :arguments
  
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  validates :type_of_debate, presence: true
  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
  def count_neutral
    evaluations.where( target_type: self.class, target_id: self.id, value: 0.0 ).count
  end
  
end
