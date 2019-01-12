# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class Plan
        def initialize(hsh)
          hsh.each do |name, value|
            instance_variable_set(:"@#{name}", value)
          end
        end

        attr_reader :list

        def to_s
          "#<Plan: #{list}>"
        end

        def inspect
          to_s
        end
      end
    end
  end
end
