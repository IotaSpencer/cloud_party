module CloudParty
  module Responses
    module Node
      class Meta
        attr_reader :auto_added, :managed_by_apps, :managed_by_argo_tunnel
        def initialize(hsh)
          @entries = []
          hsh.each do |key, value|
            @entries << "#{key}=#{value}"
          end
          auto_added = DateTime.iso8601(hsh.dig(:auto_added))
          managed_by_apps = DateTime.iso8601(hsh.dig(:managed_by_apps))
          managed_by_argo_tunnel = hsh.dig(:managed_by_argo_tunnel)

        end
        def to_s
          "#<Meta: #{@entries}>"
        end
        def inspect
          to_s
        end
      end
    end
  end
end