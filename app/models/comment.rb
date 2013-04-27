class Comment < ActiveRecord::Base
  attr_accessible :content
  
  has_ancestry
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

end
