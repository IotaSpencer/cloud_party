# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class Permissions
        def initialize(array)
          @perms = {}
          array.each do |perm|
            perm_obj = parse_perm(perm)
            @perms[perm_obj[:perm_name]] ||= []
            @perms[perm_obj[:perm_name]] << perm_obj[:perm_value]
          end
        end

        def parse_perm(perm)
          pattern = /\#(?<perm_name>.+):(?<perm_value>.+)/
          pattern.match(perm)
        end

        attr_reader :perms

        def to_s
          "#<Permissions: #{perms}>"
        end

        def inspect
          to_s
        end
      end
    end
  end
end
