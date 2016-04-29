# /lib/pokeapi/api_request.rb
# @author Jaime Rump
# This class actually makes contact with the API

require 'faraday'

module Pokeapi
  class ApiRequest

    BASE_URL = 'http://pokeapi.co/api/v2'

    def initialize(resource_uri)
      @resource_uri = self.class.trim_slashes(resource_uri)
    end

    # Executes the request and parses the result json
    # @return [Hash]
    def response
      api_response = Faraday.get(full_url)
      JSON.parse(api_response.body)
    end

    def full_url
      "#{BASE_URL}/#{@resource_uri}/"
    end

    private

    def self.trim_slashes(uri)
      uri.chomp('/').reverse.chomp('/').reverse
    end

  end
end