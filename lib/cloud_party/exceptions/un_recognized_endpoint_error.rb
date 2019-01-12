# frozen_string_literal: true

##
# UnRecognizedEndpointError
#
# When an endpoint is not recognized by the gem logic
class UnRecognizedEndpointError < StandardError
  attr_reader :endpoint, :klass
  def initialize(endpoint, klass)
    super("'#{endpoint}' is not a recognized endpoint for class #{klass}")
    @endpoint = endpoint
    @klass = klass
  end
end