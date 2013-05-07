class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:omniauthable

  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  #has_secure_password
  
  has_many :microposts, dependent: :destroy
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships
  
  has_many :arguments
  has_many :debates, through: :arguments, source: :argumentable, source_type: :'Debate'
  has_many :doulins, through: :arguments, source: :argumentable, source_type: :'Doulin'
  
  has_many :performances
  has_many :challenges, through: :performances
  
  
  has_many :argcoms
  
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  has_reputation :likes, source: {reputation: :likes, of: :arguments}, aggregated_by: :sum
  has_reputation :votes, source: {reputation: :votes, of: :debates}, aggregated_by: :sum
  has_reputation :vote_experts, source: {reputation: :vote_experts, of: :doulins}, aggregated_by: :sum

    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true
    #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #validates :email, presence:   true,
                   # format:     { with: VALID_EMAIL_REGEX },
                    #uniqueness: { case_sensitive: false }
    #validates :password, presence: true, length: { minimum: 6 }
    #validates :password_confirmation, presence: true
    
    def feed
       Micropost.from_users_followed_by(self)
    end
    
    def following?(other_user)
      relationships.find_by_followed_id(other_user.id)
    end

    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end
    
    def unfollow!(other_user)
      relationships.find_by_followed_id(other_user.id).destroy
    end
    
    def debating?(debate)
      debates.find_by_id(debate.id)
    end
    
    def in_challenges?(challenge)
      challenges.find_by_id(challenge.id)
    end
      
    
private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
    

end