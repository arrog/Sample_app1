class Doulin < ActiveRecord::Base
  include ::PublicActivity::Common
    
  attr_accessible :context, :title, :tag_list, :cat_id, :avatar
  
  acts_as_taggable
  acts_as_followable
    
  belongs_to :cat
      
  has_many :arguments, as: :argumentable
  has_many :repliques, as: :replicable
  has_many :expertises
  has_many :users, through: :expertises
  
  has_many :comments, as: :commentable
  
  has_reputation :vote_experts, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :context, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3
  

  has_attached_file :avatar,
                    :styles =>  { :medium => "165x165>"},
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'challenge-avatar',
                    :default_url => "default_:style.jpg",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'
  
                        
  scope :permission_doulin, -> { where(:state => ["online", "first", "third", "fifth", "seventh","second", "fourth", "sixth", "eighth","over"]) }

  paginates_per 10
  
  state_machine initial: :offline do
    
    event :ready do
      transition :offline => :complete_off
    end
    
    event :publish do
      transition :complete_off => :online
    end

    event :start do
      transition :online => :first
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
      transition :eighth => :over
    end
  end
  
  def first_user
    expertises.where(position:1).first.user
  end
  
  def second_user
    expertises.where(position:2).first.user
  end
  
  def have_first?
    expertises.where(position:1).any?
  end
  
  def have_second?
    expertises.where(position:2).any?
  end
  
  def count_for
    evaluations.where( target_type: self.class, target_id: self.id, value: 1.0 ).count
  end
  
  def count_against
    evaluations.where( target_type: self.class, target_id: self.id, value: -1.0 ).count
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
  
end
