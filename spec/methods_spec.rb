require 'spec_helper'

describe '#assert_schema_conform', type: :request do
  include Committee::Rails::Test::Methods

  def schema_path
    Rails.root.join('schema', 'schema.json')
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
