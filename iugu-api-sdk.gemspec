# frozen_string_literal: true

require "English"

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "iugu/version"

Gem::Specification.new do |spec|
  spec.name          = "iugu-api-sdk"
  spec.version       = Iugu::VERSION
  spec.authors       = ["Marcelo Paez Sequeira"]
  spec.email         = ["marcelo@iugu.com"]
  spec.summary       = "Iugu API"
  spec.homepage      = "https://iugu.com"
  spec.license       = "MIT"
  spec.files = Dir["{lib}/**/*"] + Dir["{docs}/**/*"] + ["Rakefile"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency "rest-client", "~> 2.1"
  spec.add_development_dependency "bundler", "~> 2.3", ">= 2.3.0"
  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "rake", "~> 13.0", ">= 10.0.0"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rubocop", "~> 1.30"
  spec.add_development_dependency "rubocop-packaging", "~> 0.5"
  spec.add_development_dependency "rubocop-performance", "~> 1.14"
  spec.add_development_dependency "rubocop-rake", "~> 0.6"
  spec.add_development_dependency "rubocop-rspec", "~> 2.11"
  spec.add_development_dependency "vcr", "~> 6.1"
  spec.add_development_dependency "webmock", "~> 3.14"
end
