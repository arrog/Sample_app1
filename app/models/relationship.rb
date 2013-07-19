class Relationship < ActiveRecord::Base
# Sender et Recivever sont inversés

  attr_accessible :reciever_id, :sender_id, :value, :state
  
  belongs_to :reciever, class_name: "User"
  belongs_to :sender, class_name: "User"

   state_machine initial: :unseen do   
     event :accept do
       transition :unseen => :accepted
     end  
     event :reject do
       transition :unseen => :rejected
     end
   end
  
end
