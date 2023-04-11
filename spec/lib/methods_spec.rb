require 'spec_helper'

describe '#assert_schema_conform', type: :request do
  include Committee::Rails::Test::Methods

  context 'when set option' do
    before do
      RSpec.configuration.add_setting :committee_options
      RSpec.configuration.committee_options = { schema_path: Rails.root.join('schema', 'schema.yml').to_s, old_assert_behavior: false, query_hash_key: 'rack.request.query_hash', parse_response_by_content_type: false, strict_reference_validation: true }
    end

    context 'and when response conform YAML Schema' do
      it 'pass' do
        post '/users', params: { nickname: 'willnet' }.to_json, headers: { 'Content-Type' =>  'application/json' }
        assert_schema_conform(200)
      end

      context 'and request with querystring' do
        it 'pass' do
          get '/users', params: { page: 1 }, headers: { 'Content-Type' =>  'application/json' }
          assert_schema_conform(200)
        end
      end

      context 'and override #request method' do
        def request
          'hi'
        end

        it 'pass' do
          post '/users', params: { nickname: 'willnet' }.to_json, headers: { 'Content-Type' =>  'application/json' }
          assert_schema_conform(200)
        end
      end

      context 'and override #response method' do
        def response
          'hi'
        end

        it 'pass' do
          post '/users', params: { nickname: 'willnet' }.to_json, headers: { 'Content-Type' =>  'application/json' }
          assert_schema_conform(200)
        end
      end
    end

    context "and when response doesn't conform YAML Schema" do
      it 'raise Committee::InvalidResponse' do
        patch '/users/1', params: { nickname: 'willnet' }.to_json, headers: { 'Content-Type' =>  'application/json', 'Accept' => 'application/json' }
        expect { assert_schema_conform(200) }.to raise_error(Committee::InvalidResponse)
      end
    end

    context 'and when bad request' do
      around do |example|
        original_show_detailed_exceptions = Rails.application.env_config['action_dispatch.show_detailed_exceptions']
        original_show_exceptions = Rails.application.env_config['action_dispatch.show_exceptions']
        Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = false
        Rails.application.env_config['action_dispatch.show_exceptions'] = true
        begin
          example.run
        ensure
          Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = original_show_detailed_exceptions
          Rails.application.env_config['action_dispatch.show_exceptions'] = original_show_exceptions
        end
      end

      it 'pass as 400' do
        patch '/users/0', params: { nickname: 'willnet' }.to_json, headers: { 'Content-Type': 'application/json', 'Accept' => 'application/json' }
        assert_schema_conform(400)
      end
    end
  end

  context 'when not set option' do
    context 'and when not override default setting' do
      before do
        RSpec.configuration.committee_options = nil
      end

      it 'use default setting' do
        post '/users', params: { nickname: 'willnet' }
        expect{ assert_schema_conform(200) }.to raise_error(Errno::ENOENT) # not exist doc/schema/schema.json
      end
    end

    context 'when override default setting' do
      def committee_options
        { schema_path: Rails.root.join('schema', 'schema.yml').to_s, old_assert_behavior: false, query_hash_key: 'rack.request.query_hash', parse_response_by_content_type: false }
      end

      it 'use the setting' do
        post '/users', params: { nickname: 'willnet' }.to_json, headers: { 'Content-Type' =>  'application/json' }
        assert_schema_conform(200)
      end
    end
  end
end
