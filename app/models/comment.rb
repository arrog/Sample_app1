class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :commentable_id, :commentable_type
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  validates_presence_of :content
end
