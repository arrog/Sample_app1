class Debate < ActiveRecord::Base
  attr_accessible :content, :title, :type_of_debate, :tag_list, :cat_id
  
  acts_as_taggable
  
  belongs_to :cat
  
  has_many :arguments, as: :argumentable
  has_many :users, through: :arguments
  
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3

  
  paginates_per 10
  
  state_machine initial: :offline do

     event :publish do
       transition :offline => :online
     end

   end
  
  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
  def count_neutral
    evaluations.where( target_type: self.class, target_id: self.id, value: 0.0 ).count
  end
  
  def valeur_vote(user)
    self.evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).first.value      
  end
  
    
end
