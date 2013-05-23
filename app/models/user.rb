class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:omniauthable

  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  #has_secure_password
  
  has_many :microposts, dependent: :destroy
  has_many :judgements
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships
  
  has_many :arguments, dependent: :destroy
  has_many :debates, through: :arguments, source: :argumentable, source_type: :'Debate'
  
  has_many :expertises
  has_many :doulins, through: :expertises, :uniq => true
  
  has_many :performances
  has_many :challenges, through: :performances, :uniq => true
  has_many :judgments
  
  has_many :argcoms, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  has_reputation :likes, source: {reputation: :likes, of: :arguments}, aggregated_by: :sum
  has_reputation :votes, source: {reputation: :votes, of: :debates}, aggregated_by: :sum
  has_reputation :vote_experts, source: {reputation: :vote_experts, of: :doulins}, aggregated_by: :sum
  
  has_many :invitations, foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_invitations, foreign_key: "reciever_id", class_name:  "Invitation", dependent:   :destroy
  
    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true
    
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
    
    def in_challenge?(challenge)
      challenges.find_by_id(challenge.id)
    end
    
    def in_challenge_expert?(doulin)
      doulin.find_by_id(doulin.id)
    end
      
    def juge_challenge?(challenge)
      performances.find_by_challenge_id(challenge.id).position == 100
    end
    
    def has_judged?(challenge)
      judgments.where(challenge_id: challenge.id).any?
    end
    
    def invite!(ohter_user,challenge,position)
      invitations.create!()
    end
    
    #rejoindre une position
    def join_position_one!(challenge)
      performances.create!(challenge_id: challenge.id, position:1)
    end
    def join_position_two!(challenge)
      performances.create!(challenge_id: challenge.id, position:2)
    end
    def join_position_three!(challenge)
      performances.create!(challenge_id: challenge.id, position:3)
    end
    def join_position_four!(challenge)
      performances.create!(challenge_id: challenge.id, position:4)
    end
    def join_position_five!(challenge)
      performances.create!(challenge_id: challenge.id, position:5)
    end
    def join_position_six!(challenge)
      performances.create!(challenge_id: challenge.id, position:6)
    end
    def join_position_seven!(challenge)
      performances.create!(challenge_id: challenge.id, position:7)
    end
    def join_position_eight!(challenge)
      performances.create!(challenge_id: challenge.id, position:8)
    end
    def join_position_judge!(challenge)
      performances.create!(challenge_id: challenge.id, position:100)
    end
    
    
    ## Notifications
    
    #def challenge_en_cours ## à perfectionner avec l'amélioration des
    #  challenges.where(state: "open")
    #end
    
    #def doulin_en_cours  ## à perfectionner avec l'amélioration des
    #  doulins.where(state: "open")
    #end
    
   # def invitation_en_cours
     # reverse_invitations.where(state: "unseen")
  #  end
    
    #def challenge_a_noter
      #performances.where(position:100).challenges.where(state: "finish")      
    #end
    
  #  def notification_arguments ## voir public activities
   # end
    
    def general_grade
      a=0
      l=0
      self.performances.each do |g|
        if g.grade_perf > 0
          a = a+ g.grade_perf
          l=l+1
        end
      end
      a=a/l
    end
    
private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
    

end