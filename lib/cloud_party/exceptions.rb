# frozen_string_literal: true

require 'cloud_party/exception'
require 'cloud_party/exceptions/request_errors'
module CloudParty
  module Errors

    ##
    # ### ConnectionError
    class ConnectionError < StandardError
      attr_reader :response

      def initialize(message, response)
        super(message)
        @response = response
      end
    end

    class UnknownError < RequestError
      def initialize(obj:, method:, response:, endpoint: nil, code:)
        super
      end

      def self.error_string
        <<~HEREDOC
          An error with the request has occurred, please make
          sure the method verb, endpoint, and credentials are
          correct for this request.
        HEREDOC
      end

      def self.extra_string
        <<~HEREDOC
          Credentials Context: #{@obj&.class&.cfg}

          Method Verb: #{@method}
          Endpoint: #{@endpoint}
          HTTP Status Code: #{@code}
          Response Body: #{@response.body}
        HEREDOC
      end
    end
    autoload :UnRecognizedResultTypeError, 'cloud_party/exceptions/un_recognized_result_type_error'
    autoload :UnRecognizedEndpointError, 'cloud_party/exceptions/un_recognized_endpoint_error'

  end
end
