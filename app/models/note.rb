class Note < ActiveRecord::Base
  attr_accessible :valeur, :participation_id, :user_id
  
  belongs_to :user
  belongs_to :participation
end
