class Challenge < ActiveRecord::Base
  attr_accessible :context, :title, :type_deb, :performances_attributes, :tag_list, :cat_id, :invitations_attributes
  
  acts_as_taggable
  
  
  
  belongs_to :cat
  
  has_many :invitations
  has_many :performances
  has_many :users, through: :performances
  
  has_many :arguments, as: :argumentable
  has_many :judgments
  
  accepts_nested_attributes_for :performances, allow_destroy: true
  
  validates :type_deb, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :context, presence: true, length: { maximum: 1000 }
                        
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3
                      
  accepts_nested_attributes_for :performances, allow_destroy: true
  accepts_nested_attributes_for :invitations, allow_destroy: true
  
  paginates_per 10
  
  scope :open_challenges, -> { with_state(:open) }
    
  state_machine initial: :incomplete do
    
    event :starting do
      transition :incomplete => :open
    end
    
    event :finish do
      transition :open => :judged
    end

    event :grade do
      transition :judged => :over
     end
  end
  
  
  def places
    if type_deb == 3
      return type_deb + 4
    else
      return type_deb + 3
    end
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
    performances.where(position: 100).count
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
  
  def second_opp
      performances.where(position:6).first.user
  end
  
  def second_prop
     performances.where(position:7).first.user
  end
  
  def second_opp
      performances.where(position:8).first.user
  end
  
  
  def grade_one
    a = 0
    judgments.each do |g|
      a = g.grade + a
    end
    a/3
  end
  
  def grade_two
    a = 0
    judgments.each do |g|
      a = g.grade_two + a
    end
    a/3
  end
  
  def grade_three
    a = 0
    judgments.each do |g|
      a = g.grade_three + a
    end
    a/3
  end
  
  def grade_four
    a = 0
    judgments.each do |g|
      a = g.grade_four + a
    end
    a/3
  end  
  
end