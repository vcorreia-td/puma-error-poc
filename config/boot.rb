$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'web')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

ENV['RACK_ENV'] ||= 'development'

require_relative 'log'
require_relative 'multi_json'
require_relative 'bugsnag'

require 'my_service_name'
require 'my_service_name/log'
require 'web'

module MyServiceName
  System = MyServiceName.dependencies(eagerly_initialize: ENV['RACK_ENV'] != 'development')
end

# Load newrelic after all other gems and files, to make sure all probes are
# enabled (otherwise some conditional probes may not load).
require_relative 'newrelic'
