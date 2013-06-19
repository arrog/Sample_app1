class Invitation < ActiveRecord::Base
  attr_accessible :challenge_id, :position, :reciever_id, :sender_id
  
  belongs_to :reciever, class_name: "User"
  belongs_to :sender, class_name: "User"
  
  belongs_to :challenge
  
  state_machine initial: :unseen do   
    event :accept do
      transition :unseen => :accepted
    end  
    event :reject do
      transition :unseen => :rejected
    end
  end
  
end
