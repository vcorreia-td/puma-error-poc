source 'https://rubygems.org'

ruby '>= 2.3.1', '< 2.5'

gem 'puma'
gem 'rack-cors'
gem 'grape'
gem 'grape-route-helpers'
gem 'oat'
gem 'grape-swagger', '~> 0.27', '>= 0.27.0'
gem 'dry-container'
gem 'oat-swagger',
  git: 'https://github.com/Talkdesk/oat-swagger.git',
  tag: 'v0.1.3-beta'

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
  gem 'rspec-hal'
  gem 'rack-test'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'colorize'
end
