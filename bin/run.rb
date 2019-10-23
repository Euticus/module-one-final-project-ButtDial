require_relative '../config/environment'


font = Figlet::Font.new('fonts/big.flf')
figlet = Figlet::Typesetter.new(font)

#figlet[Welcome to ButtDial | lolcat -a -d 1"

puts figlet['Welcome to ButtDial']

bdsession = ButtDial.new
bdsession.run
# binding.pry


puts "Until next time-- ButtDial it in"
