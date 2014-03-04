class Article < ActiveRecord::Base
  attr_accessible :name, :url, :avatar
  
  has_attached_file :avatar,
                    :styles =>  { :large => "300x300>", :medium => "150x150>", :small => "50x50>", :tiny => "30x30>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":class/:attachment/:id/:style.:extension",
                    :bucket => 'moutoner-first',
                    :default_url => "default_:style.jpg",
                    :s3_permissions => :private,
                    :s3_host_name => 's3-eu-west-1.amazonaws.com'
end
