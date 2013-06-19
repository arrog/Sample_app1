class Membership < ActiveRecord::Base
  attr_accessible :group_id, :role, :user_id, :state
  
  belongs_to :user
  belongs_to :group
  
  
  state_machine initial: :unseen do   
    event :accept do
      transition :unseen => :accepted
      transition :invited => :accepted
    end  
    event :reject do
      transition :unseen => :rejected
      transition :invited => :rejected
    end
  end
  
  
end
