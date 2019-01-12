# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class Permissions
        def initialize(array)
          perms = []
          array.each do |perm|
            perms << parse_perm(perm)
          end
          @perms = {}
        end

        def parse_perm(perm)
          pattern = /\#(?<perm_name>.+):(?<perm_value>.+)/
          perm_obj = pattern.match(perm)
          @perms[perm_obj['perm_name']] = []
          @perms[perm_obj['perm_name']] << perm_obj['perm_value']
        end

        attr_reader :list

        def to_s
          "#<Permissions: #{list}>"
        end

        def inspect
          to_s
        end
      end
    end
  end
end
