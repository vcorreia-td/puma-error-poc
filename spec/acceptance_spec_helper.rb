require 'integration_spec_helper'

require 'rack/test'
require 'pry'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include GrapeRouteHelpers::NamedRouteMatcher
end

def app
  MyServiceName::Web
end
