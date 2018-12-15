require 'httparty'
module CloudParty
  module Context
    @@base_url = ("https://api.cloudflare.com/client/v4")
    def self.included(base)
      base.extend HTTParty
      base.attr_reader(:response)
      base.attr_reader(:email, :api_key)

    end
    def self.base_uri(endpoint_path)
      if endpoint_path.start_with? '/'
        [@@base_url, endpoint_path].join('')
      else
        [@@base_url, endpoint_path].join('/')
      end

    end

    def initialize(email, api_key)
      @email   = email
      @api_key = api_key
      headers 'X-Auth-Email' => @email
      headers 'X-Auth-Key' => @api_key
      headers 'Content-Type' => 'application/json'
      headers 'User-Agent' => "CloudParty/#{CloudParty::VERSION}"
    end
  end
end
