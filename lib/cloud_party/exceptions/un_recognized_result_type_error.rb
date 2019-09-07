
##
# Raised when the result's `body` is not a recognized class
module CloudParty
  module Errors
    class UnRecognizedResultTypeError < StandardError
      attr_reader :result_class

      def initialize(result_object)
        @result_class = result_object.class
      end
    end
  end
end