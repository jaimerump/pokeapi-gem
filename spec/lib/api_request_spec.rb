require 'spec_helper'

describe Pokeapi::ApiRequest do

  it "constructs a url" do
    ar = Pokeapi::ApiRequest.new('ability/1')
    expect(ar.full_url).to eq('http://pokeapi.co/api/v2/ability/1/?')
  end

  it "can handle slashes" do
    ar = Pokeapi::ApiRequest.new('ability/1')
    expect(ar.full_url).to eq('http://pokeapi.co/api/v2/ability/1/?')

    ar = Pokeapi::ApiRequest.new('/ability/1')
    expect(ar.full_url).to eq('http://pokeapi.co/api/v2/ability/1/?')

    ar = Pokeapi::ApiRequest.new('/ability/1/')
    expect(ar.full_url).to eq('http://pokeapi.co/api/v2/ability/1/?')
  end

  context "when given query params" do 
    
    it "generates a query string" do 
      ar = Pokeapi::ApiRequest.new('/ability', limit: 20, offset: 20)
      expect(ar.full_url).to eq('http://pokeapi.co/api/v2/ability/?limit=20&offset=20')
    end

  end

  describe "#response" do 

    it "returns a hash" do 
      VCR.use_cassette('first_ability') do
        ar = Pokeapi::ApiRequest.new('ability/1')
        expect(ar.response).to be_a Hash
      end
    end

  end

end