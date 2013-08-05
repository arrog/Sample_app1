class Group < ActiveRecord::Base
  attr_accessible :description, :title, :avatar

  
  has_many :memberships
  has_many :users, through: :memberships, :uniq => true
  has_many :microposts
 
  has_attached_file :avatar,
                    :styles =>  { :huge => "596x321", :large => "427x133>", :medium => "165x165>"},
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'group-avatar',
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
  
  def group_debates
    Debate.where(group: self.id)
  end
  
  def group_challenges
    Challenge.where(group: self.id)
  end
  
  def group_toinvite
    User.all - self.users
  end
end
