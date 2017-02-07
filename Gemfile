source 'https://rubygems.org'

ruby '2.3.1', engine: 'jruby', engine_version: '9.1.7.0'

gem 'puma'
gem 'rack-cors'
gem 'grape'
gem 'grape-route-helpers'
gem 'oat'
gem 'grape-swagger'
gem 'dry-container'

gem 'oj', platforms: :ruby
gem 'jrjackson', platforms: :jruby
gem 'multi_json'
gem 'logging'
gem 'newrelic_rpm'
gem 'bugsnag'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug', platforms: :ruby
  gem 'pry-debugger-jruby', platforms: :jruby
end

group :test do
  gem 'rspec'
  gem 'rspec-given'
  gem 'rack-test'
end
