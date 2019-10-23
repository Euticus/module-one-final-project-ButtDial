class User < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :restaurants, through: :bathroom_codes

  @@session_user_obj = nil

  def self.prompt_instance
    TTY::Prompt.new
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
      #menu.choice 'Find codes for a specific restaurant', -> {Restaurant.find_by_restaurant}
      menu.choice 'Logout', -> {ButtDial.new.generate_menu}
    end
  end

  def self.get_user_object(username)
    User.find_by username: username
  end

  def list_my_codes
    my_codes = self.bathroom_codes
    if my_codes.length == 0
      puts "Looks like you didn't log any codes yet. Why don't you make some?"
    else 
      self.print_code_info(my_codes)
    end
    User.generate_user_session_menu(self.username)
  end

  def print_code_info(codes)
    print_separator
    codes.each do |code|
      puts "Restaurant: #{code.restaurant.name}"
      puts "Location: #{code.restaurant.location}"
      puts "Code: #{code.bathroom_code}"
      print_separator
    end
  end

  def self.generate_create_account_menu
    user_input = prompt_instance.ask("What do you want your username to be?")
    User.create(username: user_input)
    puts "Thanks for joining ButtDial!"
    generate_user_session_menu(user_input)
  end

  def print_separator
    puts "=" * 25
  end
end 
