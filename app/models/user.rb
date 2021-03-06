class User < ActiveRecord::Base
after_create :send_welcome_email 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :content

  include ::PublicActivity::Common
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  acts_as_follower
  acts_as_followable
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar
  
  has_many :relationships, foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "reciever_id", class_name:  "Relationship", dependent:   :destroy
  has_many :contacts, through: :relationships, source: :reciever
  has_many :contacted, through: :relationships, source: :sender
  
  has_many :microposts, dependent: :destroy
  has_many :judgements, dependent: :destroy
  
  has_many :arguments, dependent: :destroy
  has_many :debates, through: :arguments, source: :argumentable, source_type: :'Debate'
  
  has_many :expertises, dependent: :destroy
  has_many :doulins, through: :expertises, :uniq => true
  
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships, :uniq => true

  has_many :participations, dependent: :destroy
  has_many :events, through: :participations, :uniq => true
    
  has_many :performances, dependent: :destroy
  has_many :challenges, through: :performances, :uniq => true
  has_many :judgments
  
  has_many :argcoms, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :repliques
  
  has_many :notes
  
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  has_reputation :likes, source: {reputation: :likes, of: :arguments}, aggregated_by: :sum
  has_reputation :votes, source: {reputation: :votes, of: :debates}, aggregated_by: :sum
  has_reputation :vote_experts, source: {reputation: :vote_experts, of: :doulins}, aggregated_by: :sum
  has_reputation :vote_challenge, source: {reputation: :vote_challenge, of: :challenges}, aggregated_by: :sum
  
  has_many :invitations, foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_invitations, foreign_key: "reciever_id", class_name:  "Invitation", dependent:   :destroy
  
  has_many :flags
  
  has_attached_file :avatar,
                    :styles =>  { :large => "300x300>", :medium => "150x150>", :small => "50x50>", :tiny => "30x30>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'moutoner-first',
                    :default_url => "default_:style.jpg",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'
                    
    
    def fitting_name
      if self.name.split.count == 1
        self.name.split('').first(12).join
      else
        [self.name.split.first.split('').first,' ', self.name.split.last.split('').first(8)].join
      end
    end
      
    
    def feed
       Micropost.from_users_followed_by(self)
    end
    
    def team!(other_user)
        Relationship.create!(reciever_id: other_user.id, value:1, sender_id: self.id)
    end
    
    def defier!(other_user)
       Relationship.create!(reciever_id: other_user.id, value:-1, sender_id: self.id)
    end
    
    def contacts
      a = []
      self.team_user.each do |l|
        a= [l.sender]+[l.reciever]+ a
      end
      a
    end
    
    def contacted
      a = []
      self.team_user.each do |l|
        a= [l.sender]+[l.reciever]+ a
      end
      a
    end
    
    def circle
      User.all - [self]
    end
    
    def in_team?(other_user)
      (Relationship.where(reciever_id: other_user.id, value:1, sender_id: self.id)+ Relationship.where(sender_id: other_user.id, value:1, reciever_id: self.id)).any?
    end
    
    def adversaire
      relationships.where(value:-1) + reverse_relationships.where(value:-1)
    end
    
    def team_user
      relationships.where(value:1) + reverse_relationships.where(value:1)
    end
    
    def noted_by?(other, event)
      participations.where(event_id: event.id).first.notes.where(user_id: other.id).any?
    end
    
    def defier?(other_user)
 (Relationship.where(reciever_id: other_user.id, value:-1, sender_id: self.id)+ Relationship.where(sender_id: other_user.id, value:-1, reciever_id: self.id)).any?
    end
    
    def notefinaleevent(event)
      a=0
      b=  self.participations.where(event_id: event.id).first.notes.count
      self.participations.where(event_id: event.id).first.notes.each do |note|
        a = a + note.valeur
      end
      if b == 0
        return "-"
      else
        
        return (a/b).ceil
      end
    end
    
    def debating?(debate)
      debates.where(id = debate.id).any?
    end
    
    def in_challenge?(challenge)
      challenges.where(id: challenge.id).any?
    end
    
    def in_challenge_expert?(doulin)
      doulins.where(id: doulin.id).any?
    end
      
    def juge_challenge?(challenge)
      ["100", "101", "102"].include?(performances.find_by_challenge_id(challenge.id).position)
    end
    
    def has_judged?(challenge)
      judgments.where(challenge_id: challenge.id).any?
    end

    def in_group?(group)
      groups.include?(group)
    end
    
    def in_group_accepted?(group)
      memberships.where(group_id: group.id, state:"accepted").any?
    end
    
    def in_group_rejected?(group)
      memberships.where(group_id: group.id, state:"rejected").any?
    end
    
    def good_participation(event)
      participations.where(event_id: event.id)
    end
    
    def rejoindre!(group)
      memberships.create!(user_id: self.id, group_id: group.id)
    end
    
    def rajouter!(group, user)
      Membership.create!(user_id: user.id, group_id: group.id, state: "accepted")
    end
    
    def participer!(event)
      participations.create!(user_id: self.id, event_id: event.id)
    end
    
    def admin_group?(group)
      memberships.where(group_id: group.id, role:"admin").any?
    end
    
    def in_event?(event)
      participations.where(event_id: event.id).any?
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
    def join_position_judge_two!(challenge)
      performances.create!(challenge_id: challenge.id, position:101)
    end
    def join_position_judge_three!(challenge)
      performances.create!(challenge_id: challenge.id, position:102)
    end
    
    def arguments_in_challenge(challenge)
      challenge.arguments.where(user_id: self.id).count
    end
    
    def has_replique?(challenge)
      repliques.where(replicable_type: "Challenge", replicable_id: challenge.id).any?
    end
    
    ## NOTIFICATION CHALLENEGES
    def debat_pret
      dc=[]
      dc
    end
    
    def challenge_active
      cha=[]     
      challenges.each do |l|
        if l.active?
          if self == l.speaking 
            cha= cha + [l]
          end
        end
      end
      cha
    end

    def doulin_active 
     dou =[]
     doulins.permission_doulin.each do |l|
      if l.state == "online"
      elsif l.first_user == self && ["first", "third", "fifth", "seventh"].include?(l.state)
        dou = dou +[l]
      elsif l.second_user == self && ["second", "forth", "sixth", "eighth"].include?(l.state)
        dou = dou + [l]
      end
     end
     dou
    end
    
    ## NOTIFICATION JUGE
     def challenges_judge
       ju = []
       challenges.where(state: "judged").each do |l|
        if self.juge_challenge?(l)
         if self.has_judged?(l)
            ju
         else
           ju = ju +[l]
         end
        end
       end
       ju
     end
    
    ## INVITATION ET TEAM REQUEST
    def join_group
      a = []
      memberships.where(role:"admin").each do  |l|
        l.group.memberships.where(state: "unseen").each do |m|
          a = a + [m]
        end
      end
      a
    end
    
    def invitation_group
      []
    end
    
    def invitation_request
      a=[]
      b=reverse_invitations.where(state: "unseen") + reverse_invitations.where(state: "accepted")
      b.each do |l|
        if self.in_challenge?(l.challenge)
          a
        elsif l.challenge.position_taken.include?(l.position)
          a
        else
          a = a + [l]
        end
      end
        a
    end
    
    def team_request
      reverse_relationships.where(state:"unseen", value:1)
    end
    
    def notifications1
      self.team_request + self.invitation_request+self.invitation_group+ self.join_group+ self.challenges_judge
    end
    
    def notifications2
      self.doulin_active+ self.challenge_active+self.debat_pret
    end
    
    def notifications
      if self.notifications1 == nil && self.notifications2 == nil
        0
      else
        (self.notifications1+self.notifications2).count
      end
    end
    ## NOTIFICATION ARGUMENT et NOTIFICATION FOLLOWER à perfectionner
    ## Ces notifications se feront directement dans public activity
    
    
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
    
    
    def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
        if user
          return user
        else
          registered_user = User.where(:email => access_token.info.email).first
          if registered_user
            return registered_user
          else
            user = User.create(name: data["name"],
              email: data["email"],
              password: Devise.friendly_token[0,20],
            )
          end
       end
    end
    
    def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
      end
    end

    def self.new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end

    def password_required?
      super && provider.blank?
    end

    def update_with_password(params, *options)
      if encrypted_password.blank?
        update_attributes(params, *options)
      else
        super
      end
    end
    
    
private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
    def send_welcome_email
        @debate = Debate.find(6)
        @debate1 = Debate.find(13)
        @challenge = Challenge.find(13)
        UserMailer.signup_confirmation(self, @debate, @debate1, @challenge).deliver
    end
    
    

end