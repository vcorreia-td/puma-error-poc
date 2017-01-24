$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'web')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

ENV['RACK_ENV'] ||= 'development'

require_relative 'log'
require_relative 'multi_json'
require_relative 'bugsnag'

require 'my_service_name'
require 'my_service_name/log'
require 'web'

require 'newrelic_rpm'

module MyServiceName

end
