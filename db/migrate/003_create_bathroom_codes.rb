class CreateBathroomCodes < ActiveRecord::Migration[5.1]
    def change 
      create_table :bathroom_codes do |bc|
        bc.integer :bathroom_code
        bc.string :description
        bc.integer :user_id
        bc.integer :restaurant_id 
      end 
    end
  end 