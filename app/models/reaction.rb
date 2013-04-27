class Reaction < ActiveRecord::Base
  attr_accessible :argument_id, :content, :user_id
  
  belongs_to :user
  belongs_to :argument
end
