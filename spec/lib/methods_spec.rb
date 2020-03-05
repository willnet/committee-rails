require 'spec_helper'

describe '#assert_schema_conform', type: :request do
  include Committee::Rails::Test::Methods

  context 'set option' do
    before do
      RSpec.configuration.add_setting :committee_options
      RSpec.configuration.committee_options = {schema_path: Rails.root.join('schema', 'schema.json').to_s }
    end

    context 'response conform JSON Schema' do
      it 'pass' do
        post '/users', params: { nickname: 'willnet' }
        assert_schema_conform
      end
    end

    context "response doesn't conform JSON Schema" do
      it 'fail' do
        patch '/users/1', params: { nickname: 'willnet' }
        expect { assert_schema_conform }.to raise_error(Committee::InvalidResponse)
      end
    end
  end

  context 'not set option' do
    context 'not override default setting' do
      before do
        RSpec.configuration.committee_options = nil
      end

      it 'use default setting' do
        post '/users', params: { nickname: 'willnet' }
        expect{ assert_schema_conform }.to raise_error(Errno::ENOENT) # not exist doc/schema/schema.json
      end
    end

    context 'override default setting' do
      def committee_options
        {schema_path: Rails.root.join('schema', 'schema.json').to_s }
      end

      it 'pass' do
        post '/users', params: { nickname: 'willnet' }
        assert_schema_conform
      end
    end
  end
end
