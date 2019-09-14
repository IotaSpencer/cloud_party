require 'cloud_party/responses/nodes/dns_records'
require 'cloud_party/exception'
require 'cloud_party/exceptions'
module CloudParty
  module Responses
    # '/zones' endpoint response object
    class DNSRecords
      include CloudParty::Response
      # @raise [CloudParty::APIError] if the library encountered
      #   an error and {#successful?} is false
      # @raise [CloudParty::UnRecognizedEndpointError] if the library encountered
      #   an unknown endpoint for this class
      def initialize(method_name, endpoint, response, options)
        @code            = response.code
        @body            = JSON.parse(response.body, symbolize_names: true)
        @parsed_response = response.parsed_response
        @success         = @body[:success]
        unless successful?
          message = <<~MESSAGE
            Unable to #{method_name.to_s.upcase} to endpoint:
            #{endpoint}. Inspect CloudParty::APIError#response
            for further details
          MESSAGE
          raise CloudParty::Errors::APIError.new(message, response)
        end
        @results = []
        if endpoint =~ /^\/zones\/:id\/dns_records\/?$/
          @body[:result].each do |res|
            @results << CloudParty::Responses::Result.new(res)
          end
        elsif endpoint =~ /^\/zones\/:id\/dns_records\/:identifier\/?$/
          if method_name == :get
            @results = CloudParty::Responses::Result.new(@body[:result])
          end
        else
          raise Errors::UnRecognizedEndpointError.new(endpoint, self.class)
        end
        if endpoint =~ /^\/zones\/:id\/dns_records\/import\/?$/
          if @body.fetch(:timing, nil)
            @timing = CloudParty::Responses::Timing.new(@body[:timing])
          end
          @errors = []
          @body[:errors].each do |err|
            @errors << CloudParty::Responses::Error.new(err)
          end
          @messages = []
          @body[:messages].each do |msg|
            @messages << CloudParty::Responses::Message.new(msg)
          end
        end
      end

      attr_reader :errors
      attr_reader :messages
      attr_reader :results

      def successful?
        @success
      end

      alias success successful?

      def result
        if check_result_type(@body[:result]) == 'Array'
          CloudParty::Responses::Result.new(@body[:result].first)
        elsif check_result_type(@body[:result]) == 'Hash'
          CloudParty::Responses::Result.new(@body[:result])
        else
          raise CloudParty::Errors::UnRecognizedResultTypeError.new(@body[:result].class)
        end
      end

      def inspect
        wanted_methods = %i[success messages errors results]
        our_methods    = methods.select do |m|
          wanted_methods.include? m
        end
        outputs        = []
        our_methods.sort.each do |m|
          outputs << "#{m}=#{send(m)}"
        end
        "#<Response: #{outputs.join(', ')}>"
      end

      def to_s
        inspect
      end
    end

    class Result
      attr :id, :name, :type, :content, :proxiable, :proxied, :ttl, :locked, :zone_id, :zone_name, :created_on, :modified_on, :meta

      def initialize(result)
        @result = result
        @result.each do |k, v|
          instance_variable_set(:"@#{k}", v) unless %i[created_on modified_on].include?(k)
        end
        date_methods = %i[created_on modified_on]
        date_methods.each do |date|
          instance_variable_set(:"@#{date}", DateTime.parse(@result[date]))
        end
      end


      def inspect
        unchanged    = %i[proxiable proxied locked]
        strings      = %i[id name type content zone_id zone_name]
        date_methods = %i[created_on modified_on]
        outputs      = []
        unchanged.each do |m|
          outputs << "#{m}=#{send(m)}"
        end
        strings.each do |string|
          outputs << "#{string}='#{send(string)}'"
        end
        date_methods.each do |date|
          outputs << "#{date}=<#{send(date)}>"
        end
        "#<Result #{outputs.join(', ')}>"
      end

      def to_s
        inspect
      end
    end
    class Error
      def initialize(error)
        @error   = error
        @code    = error.fetch(:code, nil)
        @message = error.fetch(:message, nil)
      end

      attr_reader :code

      attr_reader :message

      def inspect
        to_s
      end

      def to_s
        wanted_methods = %i[code message]
        our_methods    = methods.select do |m|
          wanted_methods.include? m
        end
        outputs        = []
        our_methods.each do |m|
          outputs << "#{m}=#{send(m)}"
        end
        "#<Error: #{output.join(', ')}>"
      end
    end
    class Message
      def initialize(message)
        @message = message
      end

      def inspect
        to_s
      end

      def to_s
        @messages.join(', ')
      end
    end
    class Timing
      attr_reader :start_time, :end_time, :process_time

      def initialize(hsh)
        @entries = []
        hsh.each do |key, value|
          @entries << "#{key}=#{value}"
        end
        start_time   = DateTime.iso8601(hsh.dig(:start_time))
        end_time     = DateTime.iso8601(hsh.dig(:end_time))
        process_time = hsh.dig(:process_time).to_i

      end

      def to_s
        "#<Timing: #{@entries}>"
      end

      def inspect
        to_s
      end
    end
  end
end