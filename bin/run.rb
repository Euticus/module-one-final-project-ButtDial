require_relative '../config/environment'


font = Figlet::Font.new('fonts/big.flf')
figlet = Figlet::Typesetter.new(font)

puts figlet['Welcome to ButtDial'].light_blue

# prng = Random.new

# url = "http://api.ipstack.com/check?access_key=5f2a1d39e29e3e253b04526e7c603795&fields=ip,region_name,city,%20latitude,longitude"
# url2 = "http://api.ipstack.com/#{prng.rand(1..126)}.#{prng.rand(128..191)}.#{prng.rand(192..223)}.#{prng.rand(224..239)}?access_key=5f2a1d39e29e3e253b04526e7c603795&fields=ip,region_name,city,%20latitude,longitude"
# apitest = APITest.new
# testhash = apitest.do_the_thing

# response = apitest.make_api_call(url)
# response_hash = apitest.parse_response(response)

# response2 = apitest.make_api_call(url2)
# response_hash2 = apitest.parse_response(response2)

# binding.pry


bdsession = ButtDial.new
bdsession.run

puts "Until next time-- ButtDial it in"
