source 'https://rubygems.org'

ruby '>= 2.3.3', '< 2.5'

gem 'puma'
gem 'rack-cors'
gem 'grape'
gem 'grape-route-helpers'
gem 'oat', '>= 0.5.1'
gem 'grape-swagger', '~> 0.27', '>= 0.27.0'
gem 'dry-container'
gem 'oat-swagger', '>= 0.1.3',
  git: 'https://github.com/Talkdesk/oat-swagger.git'

gem 'oj', platforms: :ruby
gem 'jrjackson', platforms: :jruby
gem 'multi_json'
gem 'logging', '2.1.0' # This is the last known version that outputs logs in Heroku
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
  gem 'rspec-hal'
  gem 'rack-test'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'colorize'
end
