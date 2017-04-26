require 'my_service_name'

require 'grape'
require 'grape-swagger'
require 'oat-swagger'
require 'grape/route_helpers'

require 'endpoints/root'
require 'endpoints/add_six'

require 'helpers/request_metadata'
require 'helpers/new_relic_instrumentation'
require 'helpers/log'
require 'helpers/bugsnag'
require 'helpers/json_parser'
require 'helpers/json_formatter'
require 'helpers/error_formatter'

module MyServiceName
  class Web < Grape::API

    helpers Helpers::RequestMetadata
    helpers Helpers::NewRelicInstrumentation
    helpers Helpers::Log
    helpers Helpers::Bugsnag

    # https://github.com/ruby-grape/grape#table-of-contents

    content_type    :json_hal, 'application/hal+json'
    parser          :json_hal, Helpers::JsonParser
    formatter       :json_hal, Helpers::JsonFormatter
    error_formatter :json_hal, Helpers::ErrorFormatter
    format          :json_hal
    default_format  :json_hal

    before do
      setup_request_metadata
      setup_new_relic_instrumentation
      setup_logger_request_metadata
      setup_bugsnag_request_metadata

      logger.info "#{env['REQUEST_METHOD']} #{env['REQUEST_URI']}"
    end

    # mount endpoints here

    mount Endpoints::Root
    mount Endpoints::AddSix

    ###

    add_swagger_documentation(
      hide_documentation_path: true,
      models: OatSwagger::Serializer.swagger_models,
    )
  end
end
