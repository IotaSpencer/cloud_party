# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class PlanPending
        def initialize(hsh)
          if hsh.nil?
            @list = nil
          else
            hsh.each do |name, value|
              instance_variable_set(:"@#{name}", value)
            end
          end
        end

        def to_s
          "#<PlanPending: #{list}>"
        end

        def inspect
          to_s
        end
      end
    end
  end
end
