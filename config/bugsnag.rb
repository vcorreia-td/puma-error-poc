require 'bugsnag'
require 'English'

BUGSNAG_API_KEY = ENV['BUGSNAG_API_KEY']

Bugsnag.configure do |c|
  c.api_key = BUGSNAG_API_KEY
  c.notify_release_stages = ['production', 'qa', 'staging']
  c.project_root = File.expand_path(File.dirname(__FILE__) + '/../')
  c.release_stage = ENV['RACK_ENV']
  c.logger = Logging.logger[Bugsnag]
  c.hostname = "#{c.release_stage[0]}-#{ENV['DYNO'] || Socket.gethostname}-#{ENV['APP_NAME']}"
  c.app_version = ENV['APP_VERSION']
end unless ['test', 'development'].include?(ENV['RACK_ENV'])

at_exit do
  $ERROR_INFO && Bugsnag.notify_or_ignore($ERROR_INFO)
end
