class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable_id, :commentable_type
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  validates_presence_of :content, length: { maximum: 1000 }
  
  validates :user_id, presence: true
end
