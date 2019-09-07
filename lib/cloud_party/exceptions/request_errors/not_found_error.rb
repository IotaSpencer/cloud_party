# frozen_string_literal: true

require 'cloud_party/exception'
module CloudParty
  module Errors
    # Page/Endpoint doesn't exist
    class NotFoundError < RequestError
      def initialize(obj:, method:, response:, endpoint: nil, code: 404)
        super
      end

      def self.error_string
        <<~HEREDOC
          There was a '404 -- Not Found' error.
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
