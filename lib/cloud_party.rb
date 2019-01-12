# frozen_string_literal: true

require 'cloud_party/version'
require 'cloud_party/context'
require 'cloud_party/response'
require 'cloud_party/responses'
require 'cloud_party/exceptions'
require 'cloud_party/nodes'
require 'cloud_party/simple'

require 'httparty'
require 'json'
require 'app_configuration'
class Hash
  #take keys of hash and transform those to a symbols
  def self.transform_keys_to_symbols(value)
    return value if not value.is_a?(Hash)
    hash = value.inject({}){|memo,(k,v)| memo[k.to_sym] = Hash.transform_keys_to_symbols(v); memo}
    return hash
  end
end
class String
  def squish!
    strip!
    gsub!(/\s+/, ' ')
    self
  end

  def squish
    dup.squish!
  end
end
module CloudParty
  autoload :Errors, 'cloud_party/exceptions'
  class Connection
    include CloudParty::Context
  end
  def self.simple_connect
    CloudParty::Simple.new.connect
  end
  def self.context_connect
    Connection.new
  end
end
