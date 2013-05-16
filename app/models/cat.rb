class Cat < ActiveRecord::Base
  attr_accessible :title
  
  has_many :challenges
  has_many :debates
  has_many :doulins
      
end
