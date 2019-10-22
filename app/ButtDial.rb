require 'tty-prompt'
require 'pry'


class ButtDial 
  
  def run 

    generate_menu
  end 
  
  def prompt_instance
      TTY::Prompt.new
  end

  def generate_menu      #First Menu screen 
      prompt_instance.select("Choose an option") do |menu|
          menu.choice 'Create a new Code', -> {create_new_code_menu}
          # menu.choice 'Login', -> {user_login}
          # menu.choice 'Exit', -> {system "exit"}
      end
  end

  def create_new_code_menu
    restaurants_array = Restaurant.all
    prompt_instance.select("Which Restaurant were you at?") do |menu_item|
      restaurants_array.each do |restaurant| 
        menu_item_string = restaurant.name + ": " + restaurant.location
        menu_item.choice menu_item_string, -> {create_new_bathroom_code(restaurant)}
      end
    end
  end

  def create_new_bathroom_code(restaurant)
    user_input = prompt_instance.ask("What's the code?", convert: :int)
    BathroomCode.create(bathroom_code: user_input, description: nil, user_id: nil, restaurant_id: restaurant.id)
  end
  


  # def user_input  #If 'Create an account selected'
  #     result = prompt_instance.collect do
  #         key(:username).ask('Create new Username', convert: :string)

  #         # key(:email).ask('What is your email?', convert: :string)
  #         #prompt.ask('What is your email?') do |q|
  #           #q.validate(/\A\w+@\w+\.\w+\Z/, 'Invalid email address')
  #           #  end
      
  #         # key(:gender).ask('What gender do you identify as?', convert: :string)
  #   end 
  #   User.create(result)
  #     #   binding.pry
  # end 

  # def user_login 
  #   result = prompt_instance.collect do 
  #     key(:username).ask ('What is your username?')
  #   end
  # end 



  # # Once we conver the 'create account' functionality



  # # login procedure
  # # prompt.ask('What is your username?') do |q|
  # #     q.validate /^[^\.]+\.[^\.]+/
  # #   end
  # #   prompt.mask('What is your password?')



  # def menu_options
  #   result = prompt.select("What would you like to do? 
  #                         (Use arrow keys to navigate options 
  #                                       and ENTER to select)") do |menu|
  #     menu.default 1
  #     menu.choice 'Look up Bathroom Codes nearby', 1 
  #     menu.choice 'Post Codes', 2 
  #     menu.choice 'View Profile', 3
  #     menu.choice 'Contact Us', 4
  #     menu.choice 'Help', 5
  #     menu.choice 'Quit', 6
  #   end 
  # end 

  # #if look up selected 
  # def look_up_menu
  #     result = prompt.select("What neighborhood are you in?") do |n|
  #         n.default 11
  #         n.choice 'Upper East Side', 1
  #         n.choice 'Chelsea', 2
  #         n.choice 'Union Square', 3
  #         n.choice 'Times Square', 4
  #         n.choice 'Hells Kitchen & Columbus Circle', 5
  #         n.choice 'Flatiron District', 6
  #         n.choice 'Garment District', 7
  #         n.choice 'Murray Hill', 8
  #         n.choice 'East & Ukrainian Village', 9 
  #         n.choice 'Lower East Side', 10
  #         n.choice 'FiDi', 11

  #     end 
  # end 
          



  # #if post codes selected
  # def post_code
  #     # result1 = prompt_instance.collect do 
  #     #   key(:restaurant_name).ask('Where were you?', convert: :string)
  #     # end 
  #     # User.restaurants.push(result)

  #     # result2 = prompt_instance.collect do 
  #     #   key(:bathroom_code).ask('What is the code?', convert: :int)
  #     # end 
  #     # User.bathroom_codes.push(result)
  #   end 

  # #if View Profile selected
  # # SELECT * FROM users WHERE username = ?

  # #If Contact us selected 
  # def contact_us 
  #   puts "I'm mean it's cool you want to talk to us
  #         but we dont really care what you have to say"
  # end 

  # #if Help is selected
  # def help_screen
  #   puts "ButtDial is a CLI-based crowdsourcing app.
  #         Post bathroom codes of stores or restaurants you've been in 
  #         or select codes of stores nearby your location!"
  # end 

  # #if Quit selected 
  # def quit_option
  #     system "exit"
  # end
end   


