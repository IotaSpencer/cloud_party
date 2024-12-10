# 
# Copyright 2019 Ken Spencer / IotaSpencer
#
# 
# File: lib/cloud_party/nodes/dns_records
# Created: 9/14/19
#
# License is in project root, MIT License is in use.
require 'cloud_party/config'
require 'cloud_party/context'
require 'cloud_party/responses'
CloudParty::Config.new
module CloudParty
  module Nodes
    class DNSRecords
      include CloudParty::Context
      include HTTParty
      base_uri 'https://api.cloudflare.com/client/v4'
      headers 'Authorization' => "Bearer #{CloudParty::Config.token}",
              'Content-Type' => 'application/json',
              'User-Agent' => "CloudParty/#{CloudParty::VERSION}"

      def self.id_by_name(zone)
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
        zone = CloudParty::Responses::Zones.new(:get, '/zones', get('/zones', query: @options), @options).result
                   if zone.is_a?(Array)
                          if zone.size > 1
                            raise CloudParty::Errors::ResultError.new()
                          else
                            zone.first.fetch(:id, nil)

                          end
                   end

      end
      def initialize(options = {})
        super()
        @options = options
      end

      def list(zone)
        zone_id = self.id_by_name(zone)
        CloudParty::Responses::DNSRecords.new(:get, '/zones/:id/dns_records', self.class.get("/zones/#{zone_id}/dns_records", @options), @options)
      end

      def get(id)
        CloudParty::Responses::DNSRecords.new(:get, '/zones/:id/dns_records', self.class.get("/zones/#{zone_id}/dns_records", @options), @options)
      end


      # Add a new DNS record to the specified zone
      #
      # @param type [String] DNS record type
      # @param name [String] DNS record name
      # @param content [String] DNS record content
      # @param opts [Hash] Additional options
      # @option opts [Integer] :ttl Time to live
      # @option opts [Integer] :priority Priority
      # @option opts [Boolean] :proxied Whether the record is proxied
      # @param zone [String] Zone to add DNS record to
      #
      # @return [CloudParty::Responses::DNSRecords] DNS records response object
      def add(type, name, content, opts, zone:)
        zone_id = nil
        options = {
            type: type,
            name: name,
            content: content
        }
        ttl = opts.fetch('ttl', nil)
        priority = opts.fetch('priority', nil)
        proxied = opts.fetch('proxied', nil)
        options.merge!(ttl: ttl) unless ttl.nil?
        options.merge!(priority: priority) unless priority.nil?
        options.merge!(proxied: proxied) unless proxied.nil?
        if zone
          zone_options = {
              match: 'all',
              name: zone,
              order: 'name'
          }
          zone_id = CloudParty::Responses::Zones.new(:get, '/zones', self.class.get('/zones', query: zone_options), @options).result.first.fetch(:id, nil)
        elsif self.class.class_variable_defined?(:@@zone)
          zone_id = @@zone
        else
          raise CloudParty::Errors::NoDefinedZoneError.new("neither the keyword 'zone:' nor the class variable @@zone ended up being defined.", nil)
        end

        CloudParty::Responses::DNSRecords.new(
            :post,
            '/zones/:id/dns_records',
            self.class.post("/zones/#{zone_id}/dns_records", body: options.to_json),
            @options)
      end
      def rem(id, zone: nil)
        zone_id = id_by_name(zone)
        CloudParty::Responses::DNSRecords.new(
            :delete,
            '/zones/:id/dns_records/:identifier',
            self.class.delete("/zones/#{zone_id}/dns_records/#{id}")
            )
      end
    end
  end
end
