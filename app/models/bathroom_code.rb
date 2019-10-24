require 'pry'

class BathroomCode < ActiveRecord::Base
  belongs_to :user 
  belongs_to :restaurant

  def self.prompt_instance
      TTY::Prompt.new
  end

  def self.list_of_all_codes
    bathroom_codes_array = BathroomCode.all
    bathroom_codes_array.each do |codes|
      puts "Restaurant: " + codes.restaurant.name.green
      puts "Location: " + codes.restaurant.location
      puts "Bathroom Code: " + codes.bathroom_code.to_s.blue
      puts "Description: " + codes.description.to_s
      print_separator
    end
    User.prompt_instance.keypress("Press anywhere to get to Menu")
    User.generate_user_session(User.get_user.username)
  end

  def self.print_separator
    puts "=".red * 25
  end

  def self.create_new_code_menu
    restaurants_array = Restaurant.all
    prompt_instance.select("Which Restaurant were you at?") do |menu_item|
      restaurants_array.each do |restaurant| 
        menu_item_string = restaurant.name + ": " + restaurant.location
        menu_item.choice menu_item_string, -> {create_new_bathroom_code(restaurant)}
      end
      menu_item.choice 'Create a new restaurant listing', -> {Restaurant.create_new_restaurant}
      menu_item.choice 'Go Back', -> {User.generate_user_session(User.get_user.username)}
    end
  end

  def self.create_new_bathroom_code(restaurant)
    user_input = prompt_instance.ask("What's the code?", convert: :int)
    if restaurant.bathroom_codes == []
      BathroomCode.create(bathroom_code: user_input, 
                          description: set_description,
                          user_id: User.get_user_id, 
                          restaurant_id: restaurant.id)
    else 
      restaurant.bathroom_codes.first.update(bathroom_code: user_input, description: set_description)
      
      puts "We updated our records"
    end 
      User.prompt_instance.keypress("Press anywhere to get to Menu")
      User.generate_user_session(User.get_user.username)
  end


  def self.set_description
    description_input = prompt_instance.ask("Would you like to add a review?", convert: :string)
  end
end 