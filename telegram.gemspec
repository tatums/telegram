# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telegram/version'

Gem::Specification.new do |spec|
  spec.name          = "telegram"
  spec.version       = Telegram::VERSION
  spec.authors       = ["tatums"]
  spec.email         = ["tatum@ashlandstudios.com"]
  spec.summary       = %q{Tool for sharing messages with your dev team.}
  spec.description   = %q{Tool for sharing messages with your dev team.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("virtus", "~> 1.0")
  spec.add_dependency("thor", "~> 0.18")
  spec.add_dependency("highline", "~> 1.6")
  spec.add_dependency("colorize", "~> 0.6")

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails"
end
