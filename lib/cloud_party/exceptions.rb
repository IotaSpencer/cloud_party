# frozen_string_literal: true

require 'cloud_party/exception'
module CloudParty
  module Errors
    autoload :UnRecognizedResultTypeError, 'cloud_party/exceptions/un_recognized_result_type_error'
    autoload :BadRequestError, 'cloud_party/exceptions/bad_request_400'
  end
end
