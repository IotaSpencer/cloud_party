# 
# Copyright 2019 Ken Spencer / IotaSpencer
#
# 
# File: lib/cloud_party/nodes/dns_records
# Created: 9/14/19
#
# License is in project root, MIT License is in use.
require 'cloud_party/config'
require 'cloud_party/helpers'
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

      def self.zone_id_by_name(zone)
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
        zone = CloudParty::Responses::Zones.new(:get, '/zones',
        get('/zones', query: @options), @options).result
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

      # Retrieve a list of DNS records for the given zone
      #
      # @param zone [String] Zone to retrieve DNS records for
      # @param opts [Hash] Additional query options
      # @option opts [String] :name Name of DNS record to search for
      # @option opts [String] :type Type of DNS record to search for
      # @option opts [Integer] :page Page number to retrieve
      # @option opts [Integer] :per_page Number of items per page
      # @option opts [String] :order Direction of results
      # @option opts [String] :comment Exact value of the DNS record comment. This is a convenience alias for comment.exact.
      # Example: Hello, world
      # @option opts [String] :"comment.absent" If this parameter is present, only records without a comment are returned.
      # @option opts [String] :"comment.contains" Substring of the DNS record comment. Comment filters are case-insensitive.
      # Example: ello, worl
      # @option opts [String] :"comment.endswith" Suffix of the DNS record comment. Comment filters are case-insensitive.
      # Example: o, world
      # @option opts [String] :"comment.present" If this parameter is present, only records with a comment are returned.
      # @option opts [String] :"comment.exact" Exact value of the DNS record comment. Comment filters are case-insensitive.
      # Example: Hello, world
      # @option opts [String] :"comment.startswith" Prefix of the DNS record comment. Comment filters are case-insensitive.
      # Example: Hello, w
      # @option opts [String] :content Exact value of the DNS record content. This is a convenience alias for content.exact.
      # Example: 127.0.0.1
      # @option opts [String] :"content.contains" Substring of the DNS record content. Content filters are case-insensitive.
      # Example: 7.0.0.
      # @option opts [String] :"content.endswith" Suffix of the DNS record content. Content filters are case-insensitive.
      # Example: .0.1
      # @option opts [String] :"content.exact" Exact value of the DNS record content. Content filters are case-insensitive.
      # Example: 127.0.0.1
      # @option opts [String] :"content.startswith" Prefix of the DNS record content. Content filters are case-insensitive.
      # Example: 127.0.
      # @option opts [String] :direction Direction to order DNS records in.
      # Allowed values: asc, desc
      # Default: asc
      # Example: desc
      # @option opts [String] :match Whether to match all search requirements or at least one (any). If set to all, acts like a logical AND between filters. If set to any, acts like a logical OR instead. Note that the interaction between tag filters is controlled by the tag-match parameter instead.
      # Allowed values: any, all
      # Default: all
      # Example: any
      # @option opts [String] :name Exact value of the DNS record name. This is a convenience alias for name.exact.
      # Example: www.example.com
      # @option opts [String] :name.contains Substring of the DNS record name. Name filters are case-insensitive.
      # Example: w.example.
      # @option opts [String] :name.endswith Suffix of the DNS record name. Name filters are case-insensitive.
      # Example: .example.com
      # @option opts [String] :name.exact Exact value of the DNS record name. Name filters are case-insensitive.
      # Example: www.example.com
      # @option opts [String] :name.startswith Prefix of the DNS record name. Name filters are case-insensitive.
      # Example: www.example
      # @option opts [String] :order Field to order DNS records by.
      # Allowed values: type, name, content, ttl, proxied
      # Default: type
      # Example: name
      # @option opts [String] :page Page number of paginated results.
      # >= 1
      # Default: 1
      # @option opts [Integer] :per_page Number of DNS records per page.
      # >= 1
      # <= 5000000
      # Default: 100
      # @option opts [String] :proxied Whether the record is receiving the performance and security benefits of Cloudflare.
      # Default: false
      # Example: true
      # @option opts [String] :search Allows searching in multiple properties of a DNS record simultaneously. This parameter is intended for human users, not automation. Its exact behavior is intentionally left unspecified and is subject to change in the future. This parameter works independently of the match setting. For automated searches, please use the other available parameters.
      # Example: www.cloudflare.com
      # @option opts [String] :tag Name of a tag which must not be present on the DNS record. Tag filters are case-insensitive.
      # Example: important
      # @option opts [String] :tag.absent Name of a tag which must not be present on the DNS record. Tag filters are case-insensitive.
      # Example: important
      # @option opts [String] :tag.contains A tag and value, of the form <tag-name>:<tag-value>. The API will only return DNS records that have a tag named <tag-name> whose value contains <tag-value>. Tag filters are case-insensitive.
      # Example: greeting:ello, world
      # @option opts [String] :tag.endswith Name of a tag whose value must end with the given value. Tag filters are case-insensitive.
      # Example: greeting:ello, world
      # @option opts [String] :tag.exact Name of a tag whose value must exactly match the given value. Tag filters are case-insensitive.
      # Example: greeting:ello, world
      # @option opts [String] :tag.startswith Name of a tag whose value must start with the given value. Tag filters are case-insensitive.
      # Example: greeting:ello, world
      # @option opts [String] :type Type of the DNS record.
      # Allowed values: A, AAAA, CAA, CERT, CNAME, DNSKEY, DS, HTTPS, LOC, MX, NAPTR, NS, OPENPGPKEY, PTR, SMIMEA, SRV, SSHFP, SVCB, TLSA, TXT, URI
      # Default: A
      # Example: A  
      # @return [CloudParty::Responses::DNSRecords] DNS records response object
      def list(zone, opts)
        zone_id = DNSRecords.zone_id_by_name(zone)
        
        CloudParty::Responses::DNSRecords.new(:get, '/zones/:id/dns_records', self.class.get("/zones/#{zone_id}/dns_records", query: opts), @options)
      end

      def search(zone, query)
        zone_id = DNSRecords.zone_id_by_name(zone)
        CloudParty::Responses::DNSRecords.new(:get, '/zones/:id/dns_records', self.class.get("/zones/#{zone_id}/dns_records", @options), @options)
      end

      def get(zone, id)
        zone_id = DNSRecords.zone_id_by_name(zone)
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
        zone_id = zone_id_by_name(zone)
        CloudParty::Responses::DNSRecords.new(
            :post,
            '/zones/:id/dns_records',
            self.class.post("/zones/#{zone_id}/dns_records", body: options.to_json),
            @options)
      end
      def rem(id, zone: nil)
        zone_id = zone_id_by_name(zone)
        CloudParty::Responses::DNSRecords.new(
            :delete,
            '/zones/:id/dns_records/:identifier',
            self.class.delete("/zones/#{zone_id}/dns_records/#{id}")
            )
      end
      def update(id, type, name, content, opts, zone: nil)
        zone_id = zone_id_by_name(zone)

      end
      
      def batch(records, zone: nil)
        zone_id = zone_id_by_name(zone)
      end
    end
  end
end
