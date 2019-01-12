# frozen_string_literal: true

require 'cloud_party/context'
require 'cloud_party/responses'
module CloudParty
  module Nodes
    class Zones
      include CloudParty::Context
      include HTTParty
      base_uri 'api.cloudflare.com:443/client/v4'
      headers 'X-Auth-Email' => cfg.email,
              'X-Auth-Key' => cfg.api_key,
              'Content-Type' => 'application/json',
              'User-Agent' => "CloudParty/#{CloudParty::VERSION}"

      def initialize(options = nil)
        super()
        @options = options
      end

      def list
        CloudParty::Responses::Zones.new(:get, '/zones', self.class.get('/zones'), @options)
      end

      def get(id)
        CloudParty::Responses::Zones.new(:get, '/zones/:id', self.class.get("/zones/#{id}"), @options)
      end
    end
  end
end
