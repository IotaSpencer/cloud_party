# frozen_string_literal: true

require 'cloud_party/responses/nodes/zones'
module CloudParty
  module Responses
    include CloudParty::Response
    # '/zones' endpoint response object
    class Zones
      # @raise [CloudParty::APIError] if the library encountered
      #   an error and {#successful?} is false
      # @raise [CloudParty::UnRecognizedEndpointError] if the library encountered
      #   an unknown endpoint for this class
      def initialize(method_name, endpoint, response, options)
        @code = response.code
        @body = JSON.parse(response.body, symbolize_names: true)
        @parsed_response = response.parsed_response
        @success = @body[:success]
        unless successful?
          message = <<~MESSAGE
            Unable to #{method_name.to_s.upcase} to endpoint:
            #{endpoint}. Inspect CloudParty::APIError#response
            for further details
          MESSAGE
          raise CloudParty::APIError.new(message, response)
        end
        @results = []
        case endpoint
        when '/zones'

          @body[:result].each do |res|
            @results << CloudParty::Responses::Result.new(res)
          end
        when '/zones/:id'
          @result = CloudParty::Responses::Result.new(@body[:result])
          @results << @result
        else
          raise UnRecognizedEndpointError.new(endpoint, self.class)
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
      attr_reader :errors
      attr_reader :messages
      attr_reader :results
      def successful?
        @success
      end
      alias success successful?


      def result
        @body[:result]
      end



      def inspect
        wanted_methods = %i[success messages errors results]
        our_methods    = methods.select do |m|
          wanted_methods.include? m
        end
        outputs = []
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
      attr_reader :id, :name, :development_mode, :original_registar, :original_dnshost, :status, :paused, :type, :permissions
      def initialize(result)
        @result = result
        @result.each do |k, v|
          @plan = CloudParty::Responses::Node::Plan.new(@result.dig(:plan))
          @plan_pending = CloudParty::Responses::Node::PlanPending.new(@result.dig(:plan_pending))
          @account = CloudParty::Responses::Node::Account.new(@result.dig(:account))
          @permissions = CloudParty::Responses::Node::Permissions.new(@result.dig(:permissions))
          instance_variable_set(:"@#{k}", v) unless %i[plan plan_pending account permissions].include?(k)
        end
      end



      def inspect
        wanted = %i[id name development_mode original_registar original_dnshost status paused type permissions]
        outputs = []
        wanted.each do |m|
          outputs << "#{m}=#{send(m)}"
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
        outputs = []
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
  end
end
