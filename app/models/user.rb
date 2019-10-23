require 'pry'
class User < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :restaurants, through: :bathroom_codes

  @@session_user_obj = nil

  def self.prompt_instance
    TTY::Prompt.new
  end

  def self.generate_login_menu
    user_input = prompt_instance.ask("What's your username?")
    generate_user_session_menu(user_input)
  end

  def self.generate_user_session_menu(username)
    user_obj = get_user_object(username)
    @@session_user_obj = user_obj
    puts "Welcome #{username}! What would you like to do?"
    prompt_instance.select("Choose an option") do |menu|
      menu.choice 'Check the codes I made', -> {user_obj.list_my_codes}
      menu.choice 'Create a new Code', -> {BathroomCode.create_new_code_menu}
      menu.choice 'Look Up code', -> {BathroomCode.list_of_all_codes}
      menu.choice 'Logout', -> {ButtDial.new.generate_menu}
    end
  end

  
  def self.create_user
     username = prompt_instance.ask("Choose a Username yo!")
     User.create(username: username)
     User.generate_user_session_menu(username)
     
  end 
  

  def self.get_user_object(username)
    User.find_by username: username
  end

  def self.get_user_id
    @@session_user_obj.id 
  end


  def list_my_codes
    #binding.pry
    if self.bathroom_codes == []
      puts "Looks like you don't have anything here. You gotta use some public restrooms STAT!"
      #binding.pry
        # prompt_instance.on(:keypress) do |event|
          # if event.value == 'j'
          #   prompt_instance.trigger(:keydown)
          # end 
        # end

    else 
      my_codes = self.bathroom_codes
      self.print_code_info(my_codes)
      User.generate_user_session_menu(self.username)
    end 
    
  end

  def print_code_info(codes)
    codes.each do |code|
      puts "Restaurant: #{code.restaurant.name}"
      puts "Location: #{code.restaurant.location}"
      puts "Code: #{code.bathroom_code}"
      puts "Description: #{code.description}"
      puts '*' * 25
    end
  end
end 
