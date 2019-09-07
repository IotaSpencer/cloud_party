# frozen_string_literal: true

require 'cloud_party/exception'
module CloudParty
  module Errors
    # Page/Endpoint doesn't exist
    class UnauthorizedError < RequestError
      def initialize(obj:, method:, response:, endpoint: nil, code: 401)
        super
      end

      def self.error_string
        <<~HEREDOC
          There was a '401 -- Unauthorized' error.
        HEREDOC
      end

      def self.extra_string
        <<~HEREDOC
          VERB: #{@method}

        HEREDOC
      end
    end
  end
end
