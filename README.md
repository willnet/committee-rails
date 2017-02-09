# Committee::Rails

[![Build Status](https://travis-ci.org/willnet/committee-rails.svg?branch=master)](https://travis-ci.org/willnet/committee-rails)
[![Gem Version](https://badge.fury.io/rb/committee-rails.svg)](https://badge.fury.io/rb/committee-rails)

You can use `assert_schema_conform` in rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'committee-rails'
```

And then execute:

    $ bundle

If you use committee prior to 2.0, you have to use committee-rails 0.1.x. Please see below.

[0.1 (0-1-stable) documentation](https://github.com/willnet/committee-rails/tree/0-1-stable)


## Usage

```ruby
describe 'request spec' do
  include Committee::Rails::Test::Methods

  def committee_schema
    @committee_schema ||= begin
      driver = Committee::Drivers::HyperSchema.new
      schema_hash = JSON.parse(File.read(Rails.root.join('schema', 'schema.json'))) # default to docs/schema/schema.json
      driver.parse(schema_hash)
    end
  end

  describe 'GET /' do
    it 'conform json schema' do
      get '/'
      assert_schema_conform
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/willnet/committee-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
