# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wiser_timezone/version'

Gem::Specification.new do |spec|
  spec.name          = "wiser_timezone"
  spec.version       = WiserTimezone::VERSION
  spec.authors       = ["Kenneth John Balgos"]
  spec.email         = ["kennethjohnbalgos@gmail.com"]
  spec.description   = ""
  spec.summary       = "Friendly Timezone on Steroids"
  spec.homepage      = "https://github.com/kennethjohnbalgos/wiser_timezone"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
