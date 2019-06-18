require 'committee'

module Committee::Rails
  module Test
    module Methods
      include Committee::Test::Methods

      def committee_schema
        # this code for 2.4.0, committee 3.x use committee_options
        @committee_schema ||= Committee::Middleware::Base.new(nil, committee_options).send(:get_schema, committee_options)
      end

      def committee_options
        if defined?(RSpec) && (options = RSpec.try(:configuration).try(:committee_options))
          options
        elsif !defined?(@committee_schema)
          { schema: default_schema }
        else
          # schema_url_prefix method call this but the user overrite committee_schema, we got error
          # we can remove in comittee 3.x
          { schema: committee_schema }
        end
      end

      def default_schema
        @default_schema ||= Committee::Drivers.load_from_file(Rails.root.join('docs', 'schema', 'schema.json').to_s)
      end

      def request_object
        request
      end

      def response_data
        [response.status, response.headers, response.body]
      end
    end
  end
end
