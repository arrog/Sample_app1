class Doulin < ActiveRecord::Base
  attr_accessible :context, :title
  
  has_many :arguments, as: :argumentable
  has_many :users, through: :arguments
  
  has_reputation :vote_experts, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :context, presence: true, length: { maximum: 140 }
  validates :title, presence: true

  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
end
