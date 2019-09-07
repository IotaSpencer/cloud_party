# frozen_string_literal: true
require 'test-helper.rb'

class ContextTest < Minitest::Test
  def test_that_cloudparty_context_is_class
    expect(connection).must_be_kind_of(CloudParty::Context)
  end
end