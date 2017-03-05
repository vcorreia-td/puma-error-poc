source 'https://rubygems.org'

ruby '2.3.1', engine: 'jruby', engine_version: '9.1.7.0'

gem 'puma'
gem 'rack-cors'
gem 'grape'
gem 'grape-route-helpers'
gem 'oat'
gem 'grape-swagger'
gem 'dry-container'
gem 'oat-swagger', git: 'https://github.com/Talkdesk/oat-swagger.git'

gem 'oj', platforms: :ruby
gem 'jrjackson', platforms: :jruby
gem 'multi_json'
gem 'logging'
gem 'newrelic_rpm'
gem 'bugsnag'

group :development, :test do
  # Includes fix for circular require warnings
  # Remove when new JRuby version includes the fix: 9.1.8.0 or 9.2.0.0
  gem 'jar-dependencies', '>= 0.3.10', platforms: :jruby
  gem 'pry'
  gem 'pry-byebug', platforms: :ruby
  gem 'pry-debugger-jruby', platforms: :jruby
end

group :test do
  gem 'rspec'
  gem 'rspec-given'
  gem 'rspec-hal'
  gem 'rack-test'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end
