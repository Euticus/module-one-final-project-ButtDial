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
    User.generate_user_session(User.get_user.username)
  end

  def self.create_new_restaurant
    new_restaurant_info = prompt_instance.collect do
      key(:name).ask('Enter a restaurant name')
      key(:location).ask('Enter an address or location')
    end
    Restaurant.create(new_restaurant_info)
    BathroomCode.create_new_code_menu
  end

  def self.print_separator
    puts "=".magenta * 25
  end
end 
