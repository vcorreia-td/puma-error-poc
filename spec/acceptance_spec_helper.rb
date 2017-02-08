require 'integration_spec_helper'

require 'rack/test'
require 'rspec/given'
require 'pry'

require 'support/api_helpers'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include MyServiceName::Support::APIHelpers
  conf.include GrapeRouteHelpers::NamedRouteMatcher
end

def app
  MyServiceName::Web
end
