class User < ActiveRecord::Base
  has_many :code
  has_many :restaurant, through: :code





end 
