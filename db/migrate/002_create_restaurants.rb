class CreateRestaurants < ActiveRecord::Migration[5.1]
    def change 
      create_table :restaurants do |r|
        r.string :name
        r.string :location 
      end 
    end
  end 
  