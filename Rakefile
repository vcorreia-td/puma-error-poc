require 'bundler/setup'
require 'grape-route-helpers'
require 'grape-route-helpers/tasks'
require_relative 'config/boot'
require 'bugsnag/tasks'

Dir.glob('lib/tasks/**/*.rake') do |t|
  import t
end

desc 'load environment.'
task :environment do
  require File.expand_path('lib/my_service_name.rb', File.dirname(__FILE__))
end
