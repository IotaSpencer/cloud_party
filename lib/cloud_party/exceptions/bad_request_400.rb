# frozen_string_literal: true

require 'cloud_party/exception'
module CloudParty
  # Request was invalid
  class BadRequest < RequestError
    def initialize(obj:, method:, response:, endpoint: nil, code: 400)
      super
    end

    def self.error_string
      <<~HEREDOC
        There was a '400 -- Bad Request' error.
      HEREDOC
    end

    def self.extra_string
      <<~HEREDOC
        VERB: #{@method}

      HEREDOC
    end
  end
end
