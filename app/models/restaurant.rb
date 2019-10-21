class Restaurant < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :users, through: :bathroom_codes

end 
