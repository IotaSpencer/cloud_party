# frozen_string_literal: true

module CloudParty
  module Response
    def self.included(base)
      # if base.def
    end

    def initialize(self_object, method_name, endpoint, response); end
  end
end
