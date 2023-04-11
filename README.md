# Committee::Rails

[![Build Status](https://github.com/willnet/committee-rails/actions/workflows/test.yml/badge.svg)](https://github.com/willnet/committee-rails/actions/workflows/test.yml)
[![Gem Version](https://badge.fury.io/rb/committee-rails.svg)](https://badge.fury.io/rb/committee-rails)

You can use `assert_response_schema_confirm` in rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'committee-rails'
```

And then execute:

    $ bundle

If you use committee prior to 5.0.0, you have to use committee-rails 0.6.x. Please see below.

[0.6 (0-6-stable) documentation](https://github.com/willnet/committee-rails/tree/0-6-stable)

If you use committee prior to 4.4.0, you have to use committee-rails 0.5.x. Please see below.

[0.5 (0-5-stable) documentation](https://github.com/willnet/committee-rails/tree/0-5-stable)

If you use committee prior to 3.0, you have to use committee-rails 0.4.x. Please see below.

[0.4 (0-4-stable) documentation](https://github.com/willnet/committee-rails/tree/0-4-stable)

If you use committee prior to 2.4, you have to use committee-rails 0.3.x. Please see below.

[0.3 (0-3-stable) documentation](https://github.com/willnet/committee-rails/tree/0-3-stable)

If you use committee prior to 2.0, you have to use committee-rails 0.1.x. Please see below.

[0.1 (0-1-stable) documentation](https://github.com/willnet/committee-rails/tree/0-1-stable)

## Usage

### normal usage

```ruby
describe 'request spec' do
  include Committee::Rails::Test::Methods

  def committee_options
    @committee_options ||= {
      schema_path: Rails.root.join('schema', 'schema.json').to_s,
      query_hash_key: 'rack.request.query_hash',
      parse_response_by_content_type: false,
    }
  end

  describe 'GET /' do
    it 'conform json schema' do
      get '/'
      assert_response_schema_confirm(200)
    end
  end
end
```

### rspec setting
If you use rspec, you can use very simple.

```ruby
RSpec.configure do |config|
  config.add_setting :committee_options
  config.committee_options = {
    schema_path: Rails.root.join('schema', 'schema.json').to_s,
    query_hash_key: 'rack.request.query_hash',
    parse_response_by_content_type: false,
  }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/willnet/committee-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
