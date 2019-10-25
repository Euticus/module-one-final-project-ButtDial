require 'pry'
class User < ActiveRecord::Base

  has_many :bathroom_codes
  has_many :restaurants, through: :bathroom_codes

  lat = @latitude
  lon = @longitude 

  @@session_user_obj = nil
  @@user_session_location = nil
  @@location = nil

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

  def self.create_user
    user_input = nil
    prompt_instance.select("Select an option") do |menu|
      menu.choice "Enter Username", -> {user_input = prompt_instance.ask("What is your username to be?")}
      menu.choice 'Go back', -> {ButtDial.new.generate_menu}
    end 
    User.create(username: user_input)
    User.generate_user_session(user_input)
  end 

  def self.generate_login_menu
    user_input = prompt_instance.ask("What's your username?")
    if User.find_by(username: user_input).nil?
      puts "Looks like your username doesn't exist. How 'bout making it?'"
      ButtDial.new.generate_menu
    else
      generate_user_session(user_input)
    end
  end

  def self.generate_user_session(username)
    user_obj = get_user_object(username)
    @@session_user_obj = user_obj
    User.set_my_location
    user_obj.print_welcome_message
    user_obj.generate_user_session_menu
  end

  def generate_user_session_menu
    binding.pry
    User.prompt_instance.select(" Choose an option") do |menu|
      menu.choice 'Check the codes I made', -> {self.list_my_codes}
      menu.choice 'Create a new Code', -> {BathroomCode.create_new_code_menu}
      menu.choice 'Look up all codes available', -> {BathroomCode.list_of_all_codes}
      menu.choice 'Delete My Entries', -> {self.delete_my_entries}
      menu.choice 'Logout', -> {ButtDial.new.generate_menu}
    end
  end

  def print_welcome_message
    print "Welcome " 
    print "#{self.username}".green 
    print "! Your current location is at "
    puts "#{@@user_session_location.city}, #{@@user_session_location.region_name}".green
  end


  def list_my_codes
    if self.bathroom_codes == []
      puts "Looks like you don't have anything here. You gotta use some public restrooms STAT!"
    else 
      my_codes = self.bathroom_codes
      self.print_code_info(my_codes)
    end 
    User.prompt_instance.keypress("Press anywhere to get to Menu")
    User.generate_user_session(self.username)
  end

  def print_code_info(codes)
    print_separator
    codes.each do |code|
      print"Restaurant: "
      puts "#{code.restaurant.name}".green
      puts "Location: #{code.restaurant.location}"
      print "Code: "
      puts "#{code.bathroom_code}".blue
      puts "Description: #{code.description}"
      print_separator
    end
  end

  def print_separator
    puts "=".magenta * 25
  end
  
  def delete_my_entries
    BathroomCode.where(user_id: self.id).destroy_all
    puts "You've deleted all your entries"
    User.prompt_instance.keypress("Press anywhere to get to Menu")
    User.generate_user_session(self.username)
  end

  def self.set_my_location
    @@user_session_location = UserLocation.new
    @@user_session_location.set_location_by_ip
    @latitude = @@user_session_location.latitude
    @longitude = @@user_session_location.longitude
    #binding.pry
  end

 def user_location(lat, lon)
    @@location = "&lat=#{lat}&lon=#{lon}"
  end 

  def self.location
    @@location
  end 
 
  def find_restarants
    ap1 = APITest.new
    testhash = ap1.do_the_thing
    APITest.parse_info(testhash)
  end 

# @@user_session_location.latitude
# @@user_session_location.longitude
 
end 
