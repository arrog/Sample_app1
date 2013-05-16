class Doulin < ActiveRecord::Base
  attr_accessible :context, :title, :tag_list, :cat_id
  
  acts_as_taggable
    
  belongs_to :cat
      
  has_many :arguments, as: :argumentable
  
  has_many :expertises
  has_many :users, through: :expertises
  
  has_reputation :vote_experts, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :context, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3

  paginates_per 10
  
  state_machine initial: :offline do
    
    event :ready do
      transition :offline => :complete_off
    end
    
    event :publish do
      transition :complete_off => :online
    end

    event :start do
      transition :online => :open
     end
  end
  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
end
