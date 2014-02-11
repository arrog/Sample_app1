class Group < ActiveRecord::Base
  attr_accessible :description, :title, :avatar

  
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, :uniq => true
  has_many :microposts, dependent: :destroy
 
  has_attached_file :avatar,
                    :styles =>  { :huge => "596x321", :large => "427x133>", :medium => "165x165>"},
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'open-debate-avatar',
                    :default_url => "group_:style.jpg",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'                
                    
  validates :title, presence: true, length: { maximum: 100 }
  validates_presence_of :description
  #validates_presence_of :avatar
  
  def memberships_admin
    memberships.where(role: "admin")
  end
  
  def admins
    s=[]
    self.memberships_admin.each do |l|
      s = s + [l.user]
    end
    s
  end
  
  def invite!(user)
    memberships.create(user_id: user.id, state:"invited")
  end
  
  def gdebates
  Debate.where(group: self.id)
  end
  
  def gchallenges
  Challenge.where(group: self.id)
  end
  
  def group_debates
    Debate.where(group: self.id) + self.microposts
  end
  
  def group_debates2
     Debate.where(group: self.id)
  end
  
  def users_attending
    self.memberships.where(state: "unseen")
  end
  
  def users_rejected
    self.memberships.where(state: "rejected")
  end
  
  def users_rejected2
    a=[]
    self.users_rejected.each do |l|
      a = a +[l.user]
    end
    a
  end  

  def users_attending2
    a=[]
    self.users_attending.each do |l|
      a = a +[l.user]
    end
    a
  end
  
  def group_users
    self.users - self.users_attending2 - self.users_rejected2
  end
  
  def group_challenges
    Challenge.where(group: self.id)
  end
  
  def group_toinvite
    User.all - self.users
  end
  
  def inviter(user)
    Membership.create(group_id: self.id, user_id: user.id, role:"invited",)
  end
end
