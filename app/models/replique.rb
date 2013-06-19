class Replique < ActiveRecord::Base
  attr_accessible :replicable_id, :replicable_type, :user_id, :content
  
  belongs_to :user
  belongs_to :replicable, polymorphic: true
end
