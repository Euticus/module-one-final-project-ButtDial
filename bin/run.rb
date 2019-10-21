require_relative '../config/environment'
require 'pry'
require 'figlet'


font = Figlet::Font.new('fonts/big.flf')
figlet = Figlet::Typesetter.new(font)

puts figlet['Welcome to ButtDial']

generate_menu

#binding.pry


puts "Yo, I gotta peee soooo bad :("
