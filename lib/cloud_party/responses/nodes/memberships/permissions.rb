# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class Permissions
        def initialize(hsh)
          perms = []
          hsh.each do |name, values|
            perm_values = values.keys.select! { |val| values[val] }
            perms << "#{name} -> #{perm_values.nil? ? 'none' : perm_values.join(', ')}"
          end
          @list = perms
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
