class Event < ActiveRecord::Base
  attr_accessible :description, :state, :title, :avatar, :location

  acts_as_taggable
  acts_as_followable
  
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations, :uniq => true
  has_many :comments, as: :commentable
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :target 
  
  state_machine initial: :offline do
    event :publish do
      transition :offline => :open
      transition :open => :full
      transition :full => :close
    end   
 
    event :over do
      transition :close => :finish
    end
    
  end
   
  has_attached_file :avatar,
                    :styles =>  { :large => "600x300>", :medium => "374*222>"},
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'open-debate-avatar',
                    :default_url => "imageod.png",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'




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
 
 def in_event?(user)
   evaluations.where(target_type: self.class, target_id: self.id, source_id: user.id).any?
 end 
 
 def lesautres(user)
  self.users - [user]
 end
end
