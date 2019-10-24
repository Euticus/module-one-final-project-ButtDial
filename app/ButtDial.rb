#require 'tty-prompt'
#require 'pry'

class ButtDial 
  
  def run 
    generate_menu
  end 
  
  def prompt_instance
      TTY::Prompt.new
  end

  def generate_menu      #First Menu screen 
      prompt_instance.select("Choose an option") do |menu|
          menu.choice 'Create Account', -> {User.create_user}
          menu.choice 'Login', -> {User.generate_login_menu}
          menu.choice 'Exit', -> {system "exit"}
      end
  end
end   


