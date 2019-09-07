# frozen_string_literal: true
module CloudParty

  module Response
    def self.included(base)
      base.include CloudParty::Responses::ResponseMethods
      base.attr_reader :body, :parsed_response, :code, :errors, :messages, :results, :result
    end

    def filter_by_account(account)
      # blah
    end
    # @param [Result] result_json_object check result type for parsing
    # @raise [UnRecognizedResultTypeError] when the result type is neither Hash nor Array
    def check_result_type(result_json_object)
      if result_json_object.is_a?(Hash)
        'Hash'
      elsif result_json_object.is_a?(Array)
        'Array'
      else
        raise UnRecognizedResultTypeError, result_json_object.class
      end
    end
  end
end
