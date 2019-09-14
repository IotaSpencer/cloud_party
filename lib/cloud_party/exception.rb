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
      def initialize(message, method, endpoint, code, body)
        super(message)
        @method   = method
        @endpoint = endpoint
        @code     = code
        @body = body
      end

      def to_s
        [error_string.squish, extra_string].join("\n")
      end

      def extra_string
        # This method should be overridden
      end

      # override error_string to provide your own error_string
      def error_string
        # This method should be overridden
      end
    end
    class InputError < ArgumentError
      attr_reader :input, :obj
      # @param [String] message message
      # @param [Object] obj object
      # @param [String] input input string
      def initialize(message, obj, input)
        super(message)
        @obj = obj
        @input = input
      end
    end
    class NoDefinedZoneError < StandardError
      attr_reader :obj
      def initialize(message, obj)
        super(message)
        @obj = obj
      end
    end
  end
end
