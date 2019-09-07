module CloudParty
  module Errors
    ##
    # 400
    autoload :BadRequestError, 'cloud_party/exceptions/request_errors/bad_request_error'
    ##
    # 401
    autoload :UnauthorizedError, 'cloud_party/exceptions/request_errors/unauthorized_error'
    ##
    # 403
    autoload :ForbiddenError, 'cloud_party/exceptions/request_errors/forbidden_error'
    ##
    # 404
    autoload :NotFoundError, 'cloud_party/exceptions/request_errors/not_found_error'
    ##
    # 405
    autoload :MethodNotAllowedError, 'cloud_party/exceptions/request_errors/method_not_allowed_error'
    ##
    # 415
    autoload :UnsupportedMediaTypeError, 'cloud_party/exceptions/request_errors/unsupported_media_type_error'
    ##
    # 429
    autoload :TooManyRequestsError, 'cloud_party/exceptions/request_errors/too_many_requests_error'
  end
end
