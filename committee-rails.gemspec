# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'committee/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "committee-rails"
  spec.version       = Committee::Rails::VERSION
  spec.authors       = ["willnet"]
  spec.email         = ["netwillnet@gmail.com"]

  spec.summary       = %q{Committee for rails}
  spec.description   = %q{Committee for rails}
  spec.homepage      = "https://github.com/willnet/committee-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "committee"
  spec.add_development_dependency "bundler", "~> 1.13.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
