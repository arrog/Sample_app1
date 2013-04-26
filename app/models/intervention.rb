class Intervention < ActiveRecord::Base
  attr_accessible :content, :title, :performance_id
  belongs_to :performance
  
  validates :performance_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

end
