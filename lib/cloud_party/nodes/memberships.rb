# frozen_string_literal: true

require 'cloud_party/context'
require 'cloud_party/responses'
module CloudParty
  module Nodes
    class Memberships
      include CloudParty::Context
      include HTTParty
      base_uri 'https://api.cloudflare.com/client/v4'
      headers 'Authorization' => "Bearer #{CloudParty::Config.token}",
              'Content-Type' => 'application/json',
              'User-Agent' => "CloudParty/#{CloudParty::VERSION}"

      def initialize(options)
        super()
        @options = options
      end

      def list
        CloudParty::Responses::Memberships.new(:get, '/memberships', self.class.get('/memberships', @options))
      rescue APIError
        raise
      end
    end
  end
end
