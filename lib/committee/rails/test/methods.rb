module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def committee_schema
        @committee_schema ||= begin
          driver = Committee::Drivers::HyperSchema.new
          schema_hash = JSON.parse(File.read(Rails.root.join('docs', 'schema', 'schema.json')))
          driver.parse(schema_hash)
        end
      end

      def assert_schema_conform
        @committee_schema ||= begin
          # The preferred option. The user has already parsed a schema elsewhere
          # and we therefore don't have to worry about any performance
          # implications of having to do it for every single test suite.
          if committee_schema
            committee_schema
          else
            schema = schema_contents

            if schema.is_a?(String)
              warn_string_deprecated
            elsif schema.is_a?(Hash)
              warn_hash_deprecated
            end

            if schema.is_a?(String)
              schema = JSON.parse(schema)
            end

            if schema.is_a?(Hash) || schema.is_a?(JsonSchema::Schema)
              driver = Committee::Drivers::HyperSchema.new

              # The driver itself has its own special cases to be able to parse
              # either a hash or JsonSchema::Schema object.
              schema = driver.parse(schema)
            end

            schema
          end
        end

        @committee_router ||= Committee::Router.new(@committee_schema,
          prefix: schema_url_prefix)

        link, _ = @committee_router.find_request_link(request)
        unless link
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
