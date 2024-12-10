# frozen_string_literal: true
require 'cloud_party/config'
require 'cloud_party/context'
require 'cloud_party/responses'
CloudParty::Config.new
module CloudParty
  module Nodes
    class Zones
      include CloudParty::Context
      include HTTParty
      base_uri 'https://api.cloudflare.com/client/v4'
      headers 'Authorization' => "Bearer #{CloudParty::Config.token}",
              'Content-Type' => 'application/json',
              'User-Agent' => "CloudParty/#{CloudParty::VERSION}"

      def self.set_id_by_name(zone)
        options = {
            match: 'all',
            name: zone,
            order: 'name'
        }
        if @options.nil?
          @options = options
        else
          @options.merge!(options)
        end

        @@zone = CloudParty::Responses::Zones.new(:get, '/zones', get('/zones', query: @options), @options).result.first.fetch(:id, nil)
      end
      def initialize(options = {})
        super()
        @options = options
      end

      def list_zones
        CloudParty::Responses::Zones.new(:get, '/zones', self.class.get('/zones'), @options)
      end
      def delete(id)
        CloudParty::Responses::Zones.new(:delete, '/zones/:id', self.class.delete(""))
      end
      def get(id)
        CloudParty::Responses::Zones.new(:get, '/zones/:id', self.class.get("/zones/#{id}"), @options)
      end
    end
  end
end
