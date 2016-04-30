require 'spec_helper'

describe Pokeapi::ApiResource do

  let(:test_ability) do 
    # Create a subclass to define .resource_name
    Class.new(Pokeapi::ApiResource) do 
      def self.resource_name
        'ability'
      end
    end
  end

  describe ".find" do 

    it "returns a single object of the subclass" do
      VCR.use_cassette('first_ability') do
        expect(test_ability.find(1)).to be_a test_ability
      end
    end

  end

  describe ".all" do 

    context "when given no arguments" do 

      it "returns the first 20 objects" do 
        VCR.use_cassette('first_20_abilities') do
          all = test_ability.all
          expect(all).to be_a Array
          expect(all.length).to eq Pokeapi::ApiResource::DEFAULT_PAGE_SIZE
          expect(all.first).to be_a test_ability
        end
      end

    end

    context "when given a page argument" do 
    
      context "less than 1" do

        it "returns the first 20 objects" do 
          VCR.use_cassette('first_20_abilities') do
            all = test_ability.all
            expect(all).to be_a Array
            expect(all.length).to eq Pokeapi::ApiResource::DEFAULT_PAGE_SIZE
            expect(all.first).to be_a test_ability
          end
        end

      end

      context "greater than 1" do 

        it "returns the next 20 objects" do 
          VCR.use_cassette('abilities_20_40') do
            all = test_ability.all(2)
            expect(all).to be_a Array
            expect(all.length).to eq Pokeapi::ApiResource::DEFAULT_PAGE_SIZE
            expect(all.first).to be_a test_ability
            expect(all.first.name).to eq "suction-cups"
          end
        end

      end

      context "and a per_page" do 

        it "returns a different page size" do 
          VCR.use_cassette('first_5_abilities') do
            all = test_ability.all(1, 5)
            expect(all).to be_a Array
            expect(all.length).to eq 5
            expect(all.first).to be_a test_ability
          end
        end

      end

    end

  end

end