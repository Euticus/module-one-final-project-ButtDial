require_relative '../config/environment'


font = Figlet::Font.new('fonts/big.flf')
figlet = Figlet::Typesetter.new(font)

puts figlet['Welcome to ButtDial'].light_blue

bdsession = ButtDial.new
bdsession.run
#binding.pry


puts "Yo, I gotta peee soooo bad :("
