class Challenge < ActiveRecord::Base
  attr_accessible :context, :title, :type_deb

  has_many :performances
  has_many :users, through: :performances
  
  has_many :arguments, as: :argumentable
  
  validates :type_deb, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :context, presence: true, length: { maximum: 1000 }
  
  
  def places
    if type_deb == 3
      return type_deb + 1
    else
      return type_deb
    end
  end
  
  def place_left
    places - users.count
  end
end
