source 'https://rubygems.org'

ruby '2.3.1', engine: 'jruby', engine_version: '9.1.7.0'

gem 'puma', '~> 3.6', '>= 3.6.2'
gem 'rack-cors'
gem 'grape'
gem 'grape-route-helpers'

group :development, :test do
  gem 'pry'
  gem 'pry-debugger-jruby', platforms: :jruby
end

group :test do
  gem 'rspec'
end
