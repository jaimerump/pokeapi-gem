# /lib/pokeapi/api_request.rb
# @author Jaime Rump
# This class actually makes contact with the API

require 'faraday'

module Pokeapi
  class ApiRequest

    BASE_HOST = 'http://pokeapi.co'
    BASE_PATH = "/api/v2"

    def initialize(resource_uri, query_params = {})
      @resource_uri = self.class.trim_slashes(resource_uri)
      @query_params = query_params
    end

    # Executes the request and parses the result json
    # @return [Hash]
    def response
      api_response = Faraday.get(full_url)
      JSON.parse(api_response.body)
    end

    def full_url
      uri = URI::HTTP.build(path: "#{BASE_PATH}/#{@resource_uri}/",
                      query: @query_params.map{|key, value| "#{key}=#{value}"}.join('&'))
      "#{BASE_HOST}#{uri.request_uri}"
    end

    private

    def self.trim_slashes(uri)
      uri.chomp('/').reverse.chomp('/').reverse
    end

  end
end