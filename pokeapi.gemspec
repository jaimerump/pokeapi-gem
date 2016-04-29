# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pokeapi/version'

Gem::Specification.new do |spec|
  spec.name          = "pokeapi"
  spec.version       = Pokeapi::VERSION
  spec.authors       = ["Jaime Rump"]
  spec.email         = ["jaime.rump@trengine.com"]

  spec.summary       = %q{Ruby wrapper for Pokeapi.co v2.}
  spec.description   = %q{Ruby wrapper for Pokeapi.co v2 because I wanted to write a gem.}
  spec.homepage      = "https://github.com/jaimerump/pokeapi-gem"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
