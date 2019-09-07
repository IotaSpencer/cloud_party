# frozen_string_literal: true

require 'cloud_party/exception'
module CloudParty
  module Errors
    # Page/Endpoint doesn't exist
    class MethodNotAllowedError < RequestError
      def initialize(obj:, method:, response:, endpoint: nil, code: 405)
        super
      end

      def self.error_string
        <<~HEREDOC
          There was a '429 -- Too many requests' error.
          You've hit the rate limit of Cloudflare
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
