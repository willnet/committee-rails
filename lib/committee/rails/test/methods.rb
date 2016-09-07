module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def schema_path
        Rails.root.join('docs', 'schema', 'schema.json')
      end

      def assert_schema_conform
        if (data = schema_contents).is_a?(String)
          warn_string_deprecated
          data = JSON.parse(data)
        end

        @schema ||= begin
          schema = JsonSchema.parse!(data)
          schema.expand_references!
          schema
        end
        @router ||= Committee::Router.new(@schema, prefix: schema_url_prefix)

        unless link = @router.find_request_link(request)
          invalid_response = "`#{request.request_method} #{request.path_info}` undefined in schema."
          raise Committee::InvalidResponse.new(invalid_response)
        end

        if validate_response?(response.response_code)
          data = JSON.parse(response.body)
          Committee::ResponseValidator.new(link).call(response.response_code, response.headers, data)
        end
      end
    end
  end
end
