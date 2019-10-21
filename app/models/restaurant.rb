class Restaurant < ActiveRecord::Base
  has_many :code
  has_many :user, through: :code




end 
