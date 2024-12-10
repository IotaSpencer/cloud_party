# frozen_string_literal: true
require 'cloud_party/config'
require 'cloud_party/context'
require 'cloud_party/responses'
CloudParty::Config.new
module CloudParty
  module Nodes
    class IPs
      include CloudParty::Context
      include HTTParty
      base_uri 'https://api.cloudflare.com/client/v4'
      headers 'Authorization' => "Bearer #{CloudParty::Config.token}",
              'Content-Type' => 'application/json',
              'User-Agent' => "CloudParty/#{CloudParty::VERSION}"

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
