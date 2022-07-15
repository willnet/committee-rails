require 'action_dispatch/http/request'

module Committee::Rails
  class RequestObject
    delegate_missing_to :@request

    def initialize(request)
      @request = request
    end

    def path
      @request.original_fullpath
    end

    def path_info
      @request.original_fullpath
    end

    def request_method
      @request.env['action_dispatch.original_request_method'] || @request.request_method
    end
  end
end
