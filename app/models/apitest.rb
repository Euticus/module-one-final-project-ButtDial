class APITest

    def do_the_thing
        uri = URI.parse("https://developers.zomato.com/api/v2.1/search?entity_id=280&entity_type=city&lat=40.7589&lon=-73.9790&radius=250")
        request = Net::HTTP::Get.new(uri)
        request["Accept"] = "application/json"
        request["User-Key"] = "772b344ef3dce2becde5c51e72f6d9a0"

        req_options = {
        use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end
    end

    def make_api_call(url)
        RestClient.get(url)
    end

    def parse_response(response)
        JSON.parse(response.body)
    end

    def print_loc_data(loc_data)
        loc_data.each do |data|
          puts "#{data[0]}: #{data[1]}"
        end
    end

    def reroll
        "http://api.ipstack.com/#{prng.rand(1..126)}.#{prng.rand(128..191)}.#{prng.rand(192..223)}.#{prng.rand(224..239)}?access_key=5f2a1d39e29e3e253b04526e7c603795&fields=ip,region_name,city,%20latitude,longitude"
    end
end