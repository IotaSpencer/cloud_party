# frozen_string_literal: true

module CloudParty
  module Errors
    class APIError < StandardError
      attr_reader(:response)
      def initialize(message, response)
        super(message)
        @response = response
      end
    end
    class RequestError < StandardError
      def initialize(obj:, method:, code:, response:, endpoint:)
        @obj      = obj
        @method   = method
        @endpoint = endpoint
        @code     = code
        @response = response
      end

      def to_s
        [error_string.squish, extra_string].join("\n")
      end

      def self.extra_string
        # This method should be overridden
      end

      # override error_string to provide your own error_string
      def self.error_string
        # This method should be overridden
      end
    end
  end
end
