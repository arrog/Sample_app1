class Argument < ActiveRecord::Base
  
  include PublicActivity::Common
  
  attr_accessible :content, :title, :position, :argcoms_attributes
  
  belongs_to :user
  belongs_to :argumentable, polymorphic: true
  has_many :argcoms
  
  has_reputation :likes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  
  accepts_nested_attributes_for :argcoms, allow_destroy: true
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  
  
  def valeur_vote(user)
    self.evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).first.value      
  end  

  def count_positive
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_negative
     evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
  def modifiable?
    if self.position == 1 && self.argumentable.state == "first"
      true
    elsif self.position == 2 && self.argumentable.state == "second"
      true
    elsif self.position == 3 && self.argumentable.state == "third"
      true
    elsif self.position == 4 && self.argumentable.state == "forth"
      true
    elsif self.position == 5 && self.argumentable.state == "fifth"
      true
    elsif self.position == 6 && self.argumentable.state == "sixth"
      true
    elsif self.position == 7 && self.argumentable.state == "seventh"
      true
    elsif self.position == 8 && self.argumentable.state == "eighth"
      true
    end     
  end
  
end
