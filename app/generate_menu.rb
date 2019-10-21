require 'tty-prompt'

def prompt_instance
    TTY::Prompt.new
end

def generate_menu
    prompt_instance.select("Choose an option") do |menu|
        menu.choice 'Create an account'
        menu.choice 'Login'
        menu.choice 'Exit', -> {system "exit"}
    end
end