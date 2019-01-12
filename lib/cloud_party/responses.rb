# frozen_string_literal: true

module CloudParty
  # base module to have responses from the API be parents of,
  # all response nodes (read: endpoints) are to have their own autoload line
  # if an endpoint has numerous uses, like Zones and its dns_records endpoint
  # a sane class is to be used instead, e.g. .../zones/#!{zone_id}/dns_records ->
  # {Responses::DnsRecords} or {Responses::Zones_DnsRecords}
  module Responses
    autoload :Memberships, 'cloud_party/responses/memberships'
    autoload :IPs, 'cloud_party/responses/ips'
    autoload :Zones, 'cloud_party/responses/zones'

    module_function

    # @param [Result] result_json_object check result type for parsing
    # @raise
    def check_result_type(result_json_object)
      if result_json_object.is_a?(Hash)
        'Hash'
      elsif result_json_object.is_a?(Array)
        'Array'
      else
        raise UnRecognizedResultTypeError, result_json_object.class
      end
    end
  end
end
