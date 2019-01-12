# frozen_string_literal: true
require 'rspec'
require 'webmock/rspec'
require 'codeclimate-test-reporter'
WebMock.disable_net_connect!(allow_localhost: true)
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'cloud_party'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
end
