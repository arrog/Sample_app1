class Flag < ActiveRecord::Base
  attr_accessible :argument_id, :user_id
  
  belongs_to :user
  belongs_to :argument
end
