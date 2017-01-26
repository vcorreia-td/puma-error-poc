require 'bundler/setup'
require 'grape-route-helpers'
require 'grape-route-helpers/tasks'
require_relative 'config/boot'

Dir.glob('lib/tasks/**/*.rake') do |t|
  import t
end
