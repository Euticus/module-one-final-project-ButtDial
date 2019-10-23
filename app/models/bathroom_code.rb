require 'pry'

class BathroomCode < ActiveRecord::Base
    belongs_to :user 
    belongs_to :restaurant

    def self.prompt_instance
        TTY::Prompt.new
    end

    def self.list_of_all_codes
        #get all the codes
        # list them by code, restaruant, address
        bathroom_codes_array = BathroomCode.all
        bathroom_codes_array.each do |codes|
            #binding.pry
          puts "Bathroom Code: " + codes.bathroom_code.to_s 
          puts "Restaurant: " + codes.restaurant.name
          puts "Location: " + codes.restaurant.location
          puts "Description: " + codes.description.to_s
          puts "*" * 25
        end 
      end


      def self.create_new_code_menu
        restaurants_array = Restaurant.all
        prompt_instance.select("Which Restaurant were you at?") do |menu_item|
          restaurants_array.each do |restaurant| 
            menu_item_string = restaurant.name + ": " + restaurant.location
            menu_item.choice menu_item_string, -> {create_new_bathroom_code(restaurant)}
          end
        end
      end

      def self.create_new_bathroom_code(restaurant)
        user_input = prompt_instance.ask("What's the code?", convert: :int)
        BathroomCode.create(bathroom_code: user_input, 
                            description: set_description,
                            user_id: User.get_user_id, 
                            restaurant_id: restaurant.id)
      end

      def self.set_description
        description_input = prompt_instance.ask("Would you like to add other description?", convert: :string)
      end 

      



end 