require 'cloud_party/version'
require 'cloud_party/context'
require 'cloud_party/response'

require 'httparty'
require 'json'

module CloudParty
  class ConnectionError < StandardError
    attr_reader :response
    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class APIError < StandardError
    attr_reader(:errors)
    def initialize(message, response)
      super(message)
      @response = response
      if response.body.fetch(:errors)
        @errors = response.errors
      end
    end
  end
  def self.connect_with(email, api_key)
    CloudParty::Context.new(email, api_key)
  end
end
