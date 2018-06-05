require_relative 'config/boot'

ENV['RACK_ENV'] = 'development'
ENV['POSTGRES_DB_URL'] ='postgres://localhost:5432/vasco.correia'

# Allow CORS when in a local environment to enable API exploration with the Swagger UI
if ENV['RACK_ENV'] == 'development'
  require 'rack/cors'

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :any
    end
  end
end

use Bugsnag::Rack

use MyServiceName::Rack::EnforceHttpsMiddleware

run MyServiceName::Web
