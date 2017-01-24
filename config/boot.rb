$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'web')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

ENV['RACK_ENV'] ||= 'development'

require 'web'
require 'my_service_name'

require_relative 'log'
require_relative 'multi_json'
require_relative 'bugsnag'

module MyServiceName

end
