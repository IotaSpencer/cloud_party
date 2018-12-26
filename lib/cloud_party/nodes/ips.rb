# frozen_string_literal: true

require 'cloud_party/context'
require 'cloud_party/responses'
module CloudParty
  module Nodes
    class IPs < CloudParty::Context
      include HTTParty
      base_uri 'api.cloudflare.com:443/client/v4'
      headers 'X-Auth-Email' => cfg.email,
              'X-Auth-Key'   => cfg.api_key,
              'Content-Type' => 'application/json',
              'User-Agent'   => "CloudParty/#{CloudParty::VERSION}"

      def initialize(options = nil)
        super()
        @options = options
      end
      def list
        CloudParty::Responses::IPs.new(:get, '/ips', self.class.get('/ips'), @options)
      end
    end
  end
end
