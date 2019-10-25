class UserLocation
    attr_reader :ip_stack_url
    attr_accessor :region_name, :city, :latitude, :longitude

    def initialize
        @ip_stack_url = "http://api.ipstack.com/check?access_key=5f2a1d39e29e3e253b04526e7c603795&fields=ip,region_name,city,%20latitude,longitude"
    end

    def set_location_by_ip
        response = self.make_api_call
        response_hash = self.parse_response(response)
        self.set_user_location_info(response_hash)
    end

    def set_user_location_info(response_hash)
        @region_name = response_hash['region_name']
        @city = response_hash['city']
        @latitude = response_hash['latitude']
        @longitude = response_hash['longitude']
    end

    def make_api_call
        RestClient.get(@ip_stack_url)
    end

    def parse_response(response)
        JSON.parse(response.body)
    end
end