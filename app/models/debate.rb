class Debate < ActiveRecord::Base
  include ::PublicActivity::Common
    
  attr_accessible :content, :title, :type_of_debate, :tag_list, :cat_id, :avatar, :state
  
  acts_as_taggable
  acts_as_followable
  
  belongs_to :cat
  
  has_many :arguments, as: :argumentable
  has_many :users, through: :arguments
  has_many :argcoms, through: :arguments
  
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true
  
  validates_presence_of :tag_list
  validates_size_of     :tag_list,
                        :maximum => 3

  has_attached_file :avatar,
                    :styles =>  { :large => "600x300>", :medium => "165x165>"},
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'open-debate-avatar',
                    :default_url => "default_:style.jpg",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'
  
  
  paginates_per 10
  
  scope :permission_debate, -> { where(:state => "online")}
  
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
  
  def rapport
    if (self.count_for+self.count_against) == 0
      0
    else
      100*self.count_for/(self.count_for+self.count_against)
    end
  end
    
end
