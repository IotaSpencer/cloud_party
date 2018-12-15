module CloudParty
  class Response
    attr_reader :body

    def initialize(method_name, endpoint, response)
      @body = JSON.parse(response, symbolize_names: true)

      unless successful?
        message = <<~MESSAGE
                        Unable to #{method_name.to_s.upcase} to endpoint: 
                        #{endpoint}. Inspect CloudParty::ConnectionError#response
                        for further details
        MESSAGE
        raise CloudParty::ConnectionError.new(message, self)
      end
    end

    def result
      body[:result].first
    end

    def results
      body[:result]
    end

    def successful?
      body[:success]
    end

    def errors
      body[:errors]
    end

    def messages
      body[:messages]
    end
  end
end
