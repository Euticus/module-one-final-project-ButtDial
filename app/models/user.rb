class User < ActiveRecord::Base
  has_many :bathroom_codes
  has_many :restaurants, through: :bathroom_codes

  @session_username

  def self.prompt_instance
    TTY::Prompt.new
  end

  def self.generate_login_menu
    user_input = prompt_instance.ask("What's your username?")
    generate_user_session_menu(user_input)
  end

  def self.generate_user_session_menu(username)
    user_obj = get_user_object(username)
    puts "Welcome #{username}! What would you like to do?"
    prompt_instance.select("Choose an option") do |menu|
      menu.choice 'Check the codes I made', -> {user_obj.list_my_codes}
      menu.choice 'Logout', -> {ButtDial.new.generate_menu}
    end
  end

  def self.get_user_object(username)
    User.find_by username: username
  end

  def list_my_codes
    my_codes = self.bathroom_codes
    self.print_code_info(my_codes)
    User.generate_user_session_menu(self.username)
  end

  def print_code_info(codes)
    codes.each do |code|
      puts "Restaurant: #{code.restaurant.name}"
      puts "Location: #{code.restaurant.location}"
      puts "Code: #{code.bathroom_code}"
      puts '*' * 25
    end
  end
end 
