# frozen_string_literal: true

require 'httparty'
require 'cloud_party/config'
module CloudParty
  class Context
    attr_reader :cfg
    define_singleton_method(:cfg) do
      CloudParty::Config.new
    end
    def self.inherited(subclass)
      # I don't know yet
    end
  end
end
