# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class Account
        def initialize(account_hsh)
          @account = account_hsh
          @name = @account[:name]
          @id = @account[:id]
        end

        attr_reader :name
        attr_reader :id

        def inspect
          outputs = []
          %i[id name].each do |var|
            outputs << "#{var}=#{send(var)}"
          end
          "#<Account #{outputs.join(', ')}>"
        end

        def to_s
          inspect
        end
      end
    end
  end
end
