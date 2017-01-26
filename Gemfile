source 'https://rubygems.org'

ruby '2.3.1', engine: 'jruby', engine_version: '9.1.7.0'

gem 'puma', '~> 3.6', '>= 3.6.2'
gem 'rack-cors'
gem 'grape'
gem 'grape-route-helpers'

gem 'oj', platforms: :ruby
gem 'jrjackson', '~> 0.4', '>= 0.4.2', platforms: :jruby
gem 'multi_json', '~> 1.12', '>= 1.12.1'
gem 'logging', '~> 2.1'
gem 'newrelic_rpm'
gem 'bugsnag', '~> 5.0', '>= 5.0.0'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug', platforms: :ruby
  gem 'pry-debugger-jruby', platforms: :jruby
end

group :test do
  gem 'rspec'
  gem 'rack-test'
end
