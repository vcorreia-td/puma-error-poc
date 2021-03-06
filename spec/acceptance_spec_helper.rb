require 'integration_spec_helper'

require 'rack/test'
require 'rspec-hal'
require 'rspec/given'
require 'rspec'

require 'support/api'
require 'support/api_authentication'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include RSpec::Hal::Helpers
  conf.include RSpec::Hal::Matchers
  conf.include MyServiceName::Support::API
  conf.include GrapeRouteHelpers::NamedRouteMatcher
end

def app
  MyServiceName::Web
end
