# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-pge/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-pge'
  spec.version       = OmniAuth::PGE::VERSION
  spec.authors       = ['Sean Callan']
  spec.email         = ['sean@seancallan.com']

  spec.summary       = 'OmniAuth strategy for PG&E.'
  spec.homepage      = 'https://github.com/doomspork/omniauth-pge'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth-oauth2', '~> 1.3'

  spec.add_development_dependency 'bundler',    '> 1.7'
  spec.add_development_dependency 'coveralls',  '~> 0.8'
  spec.add_development_dependency 'rack-test',  '~> 0.6.3'
  spec.add_development_dependency 'rake',       '~> 10.0'
  spec.add_development_dependency 'rspec',      '~> 3.2'
  spec.add_development_dependency 'simplecov',  '~> 0.10'
  spec.add_development_dependency 'webmock',    '~> 1.21'
end
