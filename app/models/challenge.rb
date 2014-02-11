class Challenge < ActiveRecord::Base
  
  include PublicActivity::Common
  
  attr_accessible :context, :title, :type_deb, :performances_attributes, :tag_list, :cat_id, :invitations_attributes, :state, :avatar, :jugebreve, :group, :content
  
  acts_as_taggable
  acts_as_followable
  
  belongs_to :cat
  
  has_many :invitations, dependent: :destroy
  has_many :performances, dependent: :destroy
  has_many :users, through: :performances
  
  has_many :arguments, as: :argumentable
  has_many :judgments, dependent: :destroy
  has_many :repliques, as: :replicable
  has_many :comments, as: :commentable
  
  accepts_nested_attributes_for :performances, allow_destroy: true
  
  validates :type_deb, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  
  has_reputation :vote_challenges, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
                        
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3
                      
  accepts_nested_attributes_for :performances, allow_destroy: true
  accepts_nested_attributes_for :invitations, allow_destroy: true
  
  paginates_per 10
  
  scope :open_challenges, -> { where(:state => ["first","second","third","forth","fifth","sixth","seventh","eighth"], group: nil)}
  scope :incomplete, -> { where(:state => ["incomplete"]) }
  scope :homepage, -> { where(:state => ["homepage"]) }  
    
  state_machine initial: :incomplete do
    
    event :starting do
      transition :incomplete => :first
    end
    
    event :next do
      transition :first => :second
      transition :second => :third
      transition :third => :forth
      transition :forth => :fifth
      transition :fifth => :sixth
      transition :sixth => :seventh
      transition :seventh => :eighth
    end
    
    event :finish do
      transition :sixth => :judged
      transition :eighth => :judged
    end
    
    event :grade do
      transition :judged => :judged_one
      transition :judged_one => :judged_two
      transition :judged_two => :over
    end
    
    event :promote do    
      transition :over => :homepage
      transition :judged => :homepage
    end
  
  end
  
  
  def places
    if jugebreve ==0
      if type_deb == 3
        return type_deb + 1
      else
        return type_deb
      end
    else
      if type_deb == 3
        return type_deb + 4
      else
        return type_deb + 3
      end
    end
  end
  
  
  def valeur_vote(user)
    self.evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).first.value      
  end
  
  def place_left
    places - users.count
  end
  
  def not_full?
    self.place_left > 0
  end
  
  def position_taken
   self.performances.map{|x| x.position}
  end
  
  def juges
    self.performances.where(position:100).count+self.performances.where(position:101).count+self.performances.where(position:102).count
  end
  
  def challenge_toinvite
    User.all - self.users
  end
  
  def lincoln_douglas_position_left
    [1,2] - self.position_taken
  end
  
  def american_position_left
    [1,2,3,4] - self.position_taken
  end
  
  def four_corner_position_left
    [1,2,3,4] - self.position_taken
  end
  
  def british_position_left
    [1,2,3,4,5,6,7,8] - self.position_taken
  end
  
  def prime_minister
    performances.where(position:1).first.user
  end
  
  def first_opponent
     performances.where(position:2).first.user
  end
 
  def second_prop
     performances.where(position:3).first.user
  end
  
  def second_opp
      performances.where(position:4).first.user
  end
  
  def third_prop
     performances.where(position:5).first.user
  end
  
  def third_opp
      performances.where(position:6).first.user
  end
  
  def fourth_prop
     performances.where(position:7).first.user
  end
  
  def fourth_opp
      performances.where(position:8).first.user
  end
  
  def first_judge
    performances.where(position: 100).first.user
  end
  
  def second_judge
    performances.where(position: 101).first.user  
  end
  
  def third_judge
    performances.where(position:102).first.user    
  end
  
  def first_judgment
    judgments.where(user_id: self.first_judge.id).first
  end
  def first_judgment_array
    judgments.where(user_id: self.first_judge.id)
  end
  
  def second_judgment
     judgments.where(user_id: self.second_judge.id).first
  end
  def second_judgment_array
    judgments.where(user_id: self.second_judge.id)
  end
  
  def third_judgment
     judgments.where(user_id: self.third_judge.id).first
  end
  def third_judgment_array
    judgments.where(user_id: self.third_judge.id)
  end
  
  def have_first_judge?
    performances.where(position:100).any?
  end
  
  def have_second_judge?
    performances.where(position:101).any?
  end
  
  def have_third_judge?
    performances.where(position:102).any?
  end
  
  def first_argument
    arguments.where(position:1).first
  end
  def second_argument
    arguments.where(position:2).first
  end
  def third_argument
    arguments.where(position:3).first
  end
  def fourth_argument
    arguments.where(position:4).first
  end
  def fifth_argument
    arguments.where(position:5).first
  end
  def sixth_argument
    arguments.where(position:6).first
  end
  def seventh_argument
    arguments.where(position:7).first
  end
  def eighth_argument
    arguments.where(position:8).first
  end
  
  def speaking
    if self.type_deb == 2
      self.speaking_ld
    elsif self.type_deb ==3
      self.speaking_american
    elsif self.type_deb == 4
      self.speaking_fc
    elsif self.type_deb == 8
      self.speaking_british
    end
  end
  
  def speaking_british
    if self.state == "first"
      self.first_opponent
    elsif self.state == "second"
      self.second_prop      
    elsif self.state == "third"
      self.second_opp
    elsif self.state == "forth"
      self.third_prop
    elsif self.state == "fifth"
      self.third_opp
    elsif self.state == "sixth"
      self.fourth_prop
    elsif self.state == "seventh"
      self.fourth_opp
    end                          
  end
  
  def speaking_american
    if self.state == "first"
      self.first_opponent
    elsif self.state == "second"
      self.second_prop      
    elsif self.state == "third"
      self.second_opp
    elsif self.state == "forth"
      self.first_opponent
    elsif self.state == "fifth"
      self.prime_minister
    end                          
  end

  def speaking_fc
    if self.state == "first"
      self.first_opponent
    elsif self.state == "second"
      self.second_prop      
    elsif self.state == "third"
      self.second_opp
    elsif self.state == "forth"
      self.prime_minister
    elsif self.state == "fifth"
      self.first_opponent
    elsif self.state == "sixth"
      self.second_prop
    elsif self.state == "seventh"
      self.second_opp
    end                         
  end    
  
  def speaking_ld
    if self.state == "first"
      self.first_opponent
    elsif self.state == "second"
      self.prime_minister      
    elsif self.state == "third"
      self.first_opponent
    elsif self.state == "forth"
      self.prime_minister
    elsif self.state == "fifth"
      self.first_opponent
    elsif self.state == "sixth"
      self.prime_minister
    elsif self.state == "seventh"
      self.first_opponent
    end                         
  end
  
  def grade_one
    a = 0
    judgments.each do |g|
      a = g.grade + a
    end
    if judgments.count == 0
      a
    else
      a/(judgments.count)
    end
  end
  
  def grade_two
    a = 0
    judgments.each do |g|
      a = g.grade_two + a
    end
    if judgments.count == 0
      a
    else
      a/(judgments.count)
    end
  end
  
  def grade_three
    a = 0
    judgments.each do |g|
      a = g.grade_three + a
    end
    if judgments.count == 0
      a
    else
      a/(judgments.count)
    end
  end
  
  def grade_four
    a = 0
    judgments.each do |g|
      a = g.grade_four + a
    end
    if judgments.count == 0
      a
    else
      a/(judgments.count)
    end
  end  
  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
  end
  
  def count_upup
    evaluations.where( target_type: self.class, target_id: self.id, value: 2.0 ).count
  end
  
  def count_downdown
     evaluations.where( target_type: self.class, target_id: self.id, value: -2.0 ).count
  end 
  
  def valeur_vote(user)
    self.evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).first.value      
  end
  
  def rapport
    if (self.count_for+self.count_against) == 0
      0
    else
      100*self.count_for/(self.count_for+self.count_against)
    end
  end
  def rapport_inverse
    if (self.count_for+self.count_against) == 0
      0
    else
    100 - self.rapport
    end
  end

def rapport_fc
  if (self.count_for+self.count_against+self.count_upup+self.count_downdown) == 0
    0
  else
    100*self.count_for/(self.count_for+self.count_against+self.count_upup+self.count_downdown)
  end
end

def rapport_fc1
  if (self.count_for+self.count_against+self.count_upup+self.count_downdown) == 0
    0
  else
    100*self.count_against/(self.count_for+self.count_against+self.count_upup+self.count_downdown)
  end
end


def rapport_fc2
  if (self.count_for+self.count_against+self.count_upup+self.count_downdown) == 0
    0
  else
    100*self.count_upup/(self.count_for+self.count_against+self.count_upup+self.count_downdown)
  end
end

def rapport_fc3
  if (self.count_for+self.count_against+self.count_upup+self.count_downdown) == 0
    0
  else
    100*self.count_downdown/(self.count_for+self.count_against+self.count_upup+self.count_downdown)
  end
end
  
end