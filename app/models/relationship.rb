class Relationship < ActiveRecord::Base
# Sender et Recivever sont inversés

  attr_accessible :reciever_id, :sender_id, :value
  
  belongs_to :reciever, class_name: "User"
  belongs_to :sender, class_name: "User"

  state_machine initial: :unseen do   
    
    event :accepter do
      transition :unseen => :accepted
    end  
    
    event :rejeter do
      transition :accepted => :rejected
      transition :unseen => :rejected
    end
  
  end
  
end
