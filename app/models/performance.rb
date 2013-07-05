class Performance < ActiveRecord::Base
  
  include ::PublicActivity::Common
  
  attr_accessible :challenge_id, :perf, :position, :user_id
  
  belongs_to :user
  belongs_to :challenge
  
  has_many :grades
  
  validates :user_id, presence: true
  validates :challenge_id, presence: true
  validates :position, presence: true
  
  
  def grade_perf
       if self.challenge.type_deb == 2
        note = grade_perf_lincoln
       elsif  self.challenge.type_deb == 3
         note = grade_perf_american
       elsif  self.challenge.type_deb == 4
         note = grade_perf_four
       else       self.challenge.type_deb == 8
         note =grade_perf_british
       end
       
       if note == nil
         0
        else
          note
        end
  end 
  
  def grade_perf_lincoln
    if self.position == 1
      self.challenge.grade_one
    else
      self.challenge.grade_two
    end
  end
  
  def grade_perf_american
    if self.position == 1 || self.position == 3
      self.challenge.grade_one
    else
      self.challenge.grade_two
    end
  end
  
  def grade_perf_four
    if self.position == 1
      self.challenge.grade_one
    elsif self.position == 2
      self.challenge.grade_two
    elsif self.position == 3
      self.challenge.grade_three
    elsif self.position == 4
      self.challenge.grade_four
    end
  end
  
  def grade_perf_british
    if self.position == 1 || self.position == 3
      self.challenge.grade_one
    elsif self.position == 2 || self.position == 4
      self.challenge.grade_two
    elsif self.position == 5 || self.position == 7
      self.challenge.grade_three
    elsif self.position == 6 || self.position == 8
      self.challenge.grade_four
    end
  end
  
  
end
