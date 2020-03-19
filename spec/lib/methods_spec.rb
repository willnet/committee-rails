require 'spec_helper'

describe '#assert_schema_conform', type: :request do
  include Committee::Rails::Test::Methods

  context 'when set option' do
    before do
      RSpec.configuration.add_setting :committee_options
      RSpec.configuration.committee_options = { schema_path: Rails.root.join('schema', 'schema.json').to_s, old_assert_behavior: false }
    end

    context 'and when response conform JSON Schema' do
      it 'pass' do
        post '/users', params: { nickname: 'willnet' }.to_json, headers: { "Content-Type" =>  "application/json" }
        assert_schema_conform
      end
    end

    context "and when response doesn't conform JSON Schema" do
      it 'raise Committee::InvalidResponse' do
        patch '/users/1', params: { nickname: 'willnet' }.to_json, headers: { "Content-Type" =>  "application/json" }
        expect { assert_schema_conform }.to raise_error(Committee::InvalidResponse)
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
        expect{ assert_schema_conform }.to raise_error(Errno::ENOENT) # not exist doc/schema/schema.json
      end
    end

    context 'when override default setting' do
      def committee_options
        { schema_path: Rails.root.join('schema', 'schema.json').to_s, old_assert_behavior: false }
      end

      it 'use the setting' do
        post '/users', params: { nickname: 'willnet' }.to_json, headers: { "Content-Type" =>  "application/json" }
        assert_schema_conform
      end
    end
  end
end
