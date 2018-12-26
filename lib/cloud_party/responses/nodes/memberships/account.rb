# frozen_string_literal: true

module CloudParty
  module Responses
    module Node
      class Account
        def initialize(account_hsh)
          @account = account_hsh
          @name = @account[:name]
          @id = @account[:id]
          @settings = @account[:settings]
        end

        attr_reader :name

        attr_reader :id

        def settings
          @settings.each do |k, v|
            settings << { k => v }
          end
        end

        def inspect
          outputs = []
          %i[id name settings].each do |var|
            if var == :settings
              settings = []
              @settings.each do |k, v|
                settings << "#{k}=#{v}"
              end
              outputs << "settings=[#{settings.join(', ')}]"
            else
              outputs << "#{var}=#{send(var)}"
            end
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
