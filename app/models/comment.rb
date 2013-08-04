class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable_id, :commentable_type
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  validates_presence_of :content, length: { maximum: 1000 }
  
  has_reputation :like_comment, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :user_id, presence: true
  
  def count_positive
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_negative
     evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
  def valeur_vote(user)
    self.evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).first.value      
  end
  
end
