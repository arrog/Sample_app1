class Argument < ActiveRecord::Base
  attr_accessible :content, :title
  
  belongs_to :user
  belongs_to :argumentable, polymorphic: true
  has_many :comments, as: :commentable
  
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 1000 }
end
