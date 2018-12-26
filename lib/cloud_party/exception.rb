# frozen_string_literal: true

module CloudParty
  class ConnectionError < StandardError
    attr_reader :response

    def initialize(message, response)
      super(message)
      @response = response
    end
  end

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

    def self.extra_string; end

    def self.error_string; end
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
end
