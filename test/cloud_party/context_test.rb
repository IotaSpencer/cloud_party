# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../test-helper.rb'

class A
  include CloudParty::Context
end


class ConfigAttrTest < Minitest::Test

  A.cfg.instance_variable_get(:@email).wont_be_nil
  A.cfg.instance_variable_get(:@api_key).wont_be_nil
end