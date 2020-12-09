lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hoverfly/version"

Gem::Specification.new do |spec|
  spec.name = "hoverfly"
  spec.version = Hoverfly::VERSION
  spec.authors = ["Josh Cass"]
  spec.email = ["josh@bonus.ly"]
  spec.summary = "A Ruby mocking library for Chargebee"
  spec.description = "Hoverfly is a drop in mocking library for testing with Chargebee."
  spec.homepage = "https://github.com/bonusly/hoverfly"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"

  spec.add_dependency "chargebee", "~> 2.8"
  spec.add_dependency "rack", "~> 2.2"
end
