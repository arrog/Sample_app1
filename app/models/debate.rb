class Debate < ActiveRecord::Base
  include ::PublicActivity::Common
    
  attr_accessible :content, :title, :article_id, :tag_list, :cat_id, :avatar, :state, :group, :context
  
  acts_as_taggable
  acts_as_followable
  
  belongs_to :cat
  
  has_many :arguments, as: :argumentable
  has_many :users, through: :arguments
  has_many :argcoms, through: :arguments
  
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :content, presence: true
  validates :title, presence: true
  
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3

  has_attached_file :avatar,
                    :styles =>  { :large => "600x300>", :medium => "374*222>"},
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'open-debate-avatar',
                    :default_url => "imageod.png",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'
  
  
  paginates_per 10
  
  scope :permission_debate, -> { where(:state => ["homepage1","homepage2","homepage3","homepage4","homepage5","online"], :group => [nil, '0'] )}
  scope :homepage1, -> { where(:state => ["homepage1"]) }  
  scope :homepage2, -> { where(:state => ["homepage2"]) }  
  scope :homepage3, -> { where(:state => ["homepage3"]) }  
  scope :homepage4, -> { where(:state => ["homepage4"]) }  
  scope :homepage5, -> { where(:state => ["homepage5"]) }
  scope :partenariat, -> { where(:state => ["partenaire","partenaire1", "partenaire2", "partenaire3"]) }  
         
  state_machine initial: :offline do

     event :publish do
       transition :offline => :online
     end
     
     event :partenariat do
       transition :offline => :partenaire
       transition :partenaire => :partenaire1
       transition :partenaire1 => :partenaire2
       transition :partenaire2 => :partenaire3                    
     end
     
     event :promote1 do
       transition :online => :homepage1
       transition :homepage => :homepage1       
       transition :homepage2 => :homepage1
       transition :homepage3 => :homepage1
       transition :homepage4 => :homepage1
       transition :homepage5 => :homepage1                     
     end
     event :promote2 do
       transition :online => :homepage2
       transition :homepage => :homepage2       
       transition :homepage1 => :homepage2
       transition :homepage3 => :homepage2
       transition :homepage4 => :homepage2
       transition :homepage5 => :homepage2       
     end
     event :promote3 do
       transition :online => :homepage3
       transition :homepage => :homepage3     
       transition :homepage2 => :homepage3
       transition :homepage1 => :homepage3
       transition :homepage4 => :homepage3
       transition :homepage5 => :homepage3       
     end
     event :promote4 do
       transition :online => :homepage4
       transition :homepage => :homepage4      
       transition :homepage2 => :homepage4
       transition :homepage3 => :homepage4
       transition :homepage1 => :homepage4
       transition :homepage5 => :homepage4       
     end
     event :promote5 do
       transition :online => :homepage5
       transition :homepage => :homepage5      
       transition :homepage2 => :homepage5
       transition :homepage3 => :homepage5
       transition :homepage4 => :homepage5
       transition :homepage1 => :homepage5       
     end
   end
  
  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count + 1
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count + 1
  end
  
  def count_neutral
    evaluations.where( target_type: self.class, target_id: self.id, value: 0.0 ).count + 1
  end
  
  def valeur_vote(user)
    self.evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).first.value      
  end
  
  def in_deb?(user)
    evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).any?
  end
  
  def rapport_oui
    if self.count_for == 0
      0
    elsif
      100*self.count_for/(self.count_for+self.count_against+self.count_neutral)      
    end
  end
  
  def rapport_non
    if self.count_against == 0
      0
    elsif
      100*self.count_against/(self.count_for+self.count_against+self.count_neutral)      
    end  
  end
  
  def rapport
    if (self.count_for+self.count_against) == 0
      0
    else
      100*self.count_for/(self.count_for+self.count_against)
    end
  end
  
  def partenaire
    if self.article_id.presence
      Article.find(self.article_id)
    end
  end
    
end
