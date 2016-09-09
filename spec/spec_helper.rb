$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bundler/setup'
require 'action_controller/railtie'
require 'committee'
Bundler.require

require 'fake_app/rails_app'
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

# RSpec.configure do |config|
#
# end
