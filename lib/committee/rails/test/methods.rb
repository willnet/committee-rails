require 'committee'
require 'committee/rails/request_object'

module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def committee_options
        if defined?(RSpec) && (options = RSpec.try(:configuration).try(:committee_options))
          options
        else
          { schema_path: default_schema, query_hash_key: 'rack.request.query_hash', parse_response_by_content_type: false }
        end
      end

      def default_schema
        @default_schema ||= Committee::Drivers.load_from_file(Rails.root.join('docs', 'schema', 'schema.json').to_s)
      end

      def request_object
        @request_object ||= Committee::Rails::RequestObject.new(integration_session.request)
      end

      def response_data
        [integration_session.response.status, integration_session.response.headers, integration_session.response.body]
      end
    end
  end
end
