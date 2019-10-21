class User < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :restaurants, through: :bathroom_codes

end 
