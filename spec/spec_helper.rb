$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

ENV['RACK_ENV'] = 'test'

require 'coveralls'
require 'simplecov'
require 'rack/test'
require 'webmock/rspec'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter 'spec'
  coverage_dir 'docs/coverage'
end

require 'omniauth'
require 'omniauth-pge'

Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.pattern = '**/*_spec.rb'
  config.mock_framework = :rspec
  config.include WebMock::API
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, type: :strategy
end
