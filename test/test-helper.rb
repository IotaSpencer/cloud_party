# frozen_string_literal: true
require 'minitest'
require 'minitest/expectations'
require 'minitest/mock'
require 'webmock/minitest'
require 'codeclimate-test-reporter'
require 'minitest/reporters'
MiniTest::Reporters.use!
WebMock.disable_net_connect!(allow_localhost: true)
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'cloud_party'


