# /lib/pokeapi/api_resource.rb
# @author Jaime Rump
# This class is a parent class for every resource that can be pulled from the API

module Pokeapi
  class ApiResource

    DEFAULT_PAGE_SIZE = 20

    attr_reader :id, :name

    def initialize(resource_hash)
      @id = resource_hash["id"]
      @name = resource_hash["name"]
    end

    # Pulls down a single object based on an identifier
    # @param [String, Integer] identifier The name or id of the object to retrieve
    # @return [ApiResource]
    def self.find(identifier)
      resource_hash = Pokeapi::ApiRequest.new("#{resource_name}/#{identifier}").response
      new(resource_hash)
    end

    # Pulls down a group of objects based on a page number and size
    # @param [Integer, nil] page
    # @param [Integer, nil] per_page
    # @return [Array<ApiResource>]
    def self.all(page = 0, per_page = DEFAULT_PAGE_SIZE)
      limit = per_page 
      offset = [0, page - 1].max * limit

      resource_hashes = Pokeapi::ApiRequest.new("#{resource_name}/", limit: limit, offset: offset).response
      resource_hashes["results"].map {|resource_hash| new(resource_hash) }
    end

  end
end