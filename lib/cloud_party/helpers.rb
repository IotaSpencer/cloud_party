require 'uri'

module CloudParty
  module Helpers
    module_function
    def self.build_query(params)
      uri = URI::HTTPS.build(host: 'example.com', query: URI.encode_www_form(params))
      return "?#{uri.query}"
    end
  end
end