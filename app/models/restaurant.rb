class Restaurant < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :users, through: :bathroom_codes

  def self.prompt_instance
    TTY::Prompt.new
  end

  def self.find_by_restaurant
    #return codes that belong to a specific restauruant
    all_restaurants_array = Restaurant.all
    generate_restaurant_listing(all_restaurants_array)
  end

  def self.generate_restaurant_listing(restaurants_array)
    prompt_instance.select("Which Restaurant do you want to look at?") do |menu_item|
      restaurants_array.each do |restaurant| 
        menu_item_string = restaurant.name + ": " + restaurant.location
        menu_item.choice menu_item_string, -> {list_restaurant_codes(restaurant)}
      end
    end
  end

  def self.list_restaurant_codes(restaurant)
    print_separator
    restaurant.bathroom_codes.each do |code|
      puts "Bathroom Code: #{code.bathroom_code}"
      puts "Description: #{code.description}"
      print_separator
    end
    User.generate_user_session_menu
  end

  def self.print_separator
    puts "=" * 25
  end
end 
