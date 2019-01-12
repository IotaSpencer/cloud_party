# frozen_string_literal: true

module CloudParty
  module Nodes
    autoload :Accounts, 'cloud_party/nodes/accounts'
    autoload :Memberships, 'cloud_party/nodes/memberships'
    autoload :IPs, 'cloud_party/nodes/ips'
    autoload :Zones, 'cloud_party/nodes/zones'
  end
end
