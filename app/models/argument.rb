class Argument < ActiveRecord::Base
  attr_accessible :content, :title, :argcoms_attributes
  
  belongs_to :user
  belongs_to :argumentable, polymorphic: true
  has_many :argcoms
  
  has_reputation :likes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  
  accepts_nested_attributes_for :argcoms, allow_destroy: true
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 1000 }
  
  
  def count_positive
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
end
