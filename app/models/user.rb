require 'pry'
class User < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :restaurants, through: :bathroom_codes

  @@session_user_obj = nil

  def self.prompt_instance
    TTY::Prompt.new
  end

  def self.get_user_object(username)
    User.find_by username: username
  end

  def self.get_user_id
    @@session_user_obj.id 
  end

  def self.get_user
    @@session_user_obj
  end

  def self.generate_login_menu
    user_input = prompt_instance.ask("What's your username?")
    #binding.pry
    if User.find_by(username: user_input).nil?
      puts "Looks like your username doesn't exist. How 'bout making it?'"
      ButtDial.new.generate_menu
    else
      @@session_username
      generate_user_session_menu(user_input)
    end
  end

  def self.generate_user_session_menu(username)
    user_obj = get_user_object(username)
    @@session_user_obj = user_obj
    puts "Welcome #{username}! What would you like to do?"
    prompt_instance.select("Choose an option") do |menu|
      menu.choice 'Check the codes I made', -> {user_obj.list_my_codes}
      menu.choice 'Create a new Code', -> {BathroomCode.create_new_code_menu}
      menu.choice 'Look Up code', -> {BathroomCode.list_of_all_codes}
      menu.choice 'Delete My Entries', -> {user_obj.delete_my_entries}
      menu.choice 'Logout', -> {ButtDial.new.generate_menu}
    end
  end

  
  def self.create_user
    prompt_instance.select("Create a Username") do |menu|
      menu.choice "Enter Username", -> {user_input =  prompt_instance.ask("What is your username to be?")}
      menu.choice 'Go back', -> {ButtDial.new.generate_menu}
    end 
    User.create(username: user_input)
    User.generate_user_session_menu(user_input)
  end 

  


  def list_my_codes
    #binding.pry
    if self.bathroom_codes == []
      puts "Looks like you don't have anything here. You gotta use some public restrooms STAT!"
      
    else 
      my_codes = self.bathroom_codes
      self.print_code_info(my_codes)
    end 
    #binding.pry
    User.prompt_instance.keypress("Press anywhere to get to Menu")
    User.generate_user_session_menu(self.username)
  end

  def print_code_info(codes)
    print_separator
    codes.each do |code|
      puts "Restaurant: #{code.restaurant.name}"
      puts "Location: #{code.restaurant.location}"
      puts "Code: #{code.bathroom_code}"
      puts "Description: #{code.description}"
      print_separator
    end
  end

 

  def print_separator
    puts "=" * 25
  end


  
  def delete_my_entries
    BathroomCode.where(user_id: self.id).destroy_all
    puts "You've deleted all your entries"
    User.prompt_instance.keypress("Press anywhere to get to Menu")
    User.generate_user_session_menu(self.username)
  end
end 
