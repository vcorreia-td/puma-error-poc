require 'my_service_name'

require 'grape'
require 'grape-swagger'
require 'oat-swagger'
require 'grape/route_helpers'

require 'endpoints/root'
require 'endpoints/add_six'

require 'helpers/request_metadata_helper'
require 'helpers/log_helper'
require 'helpers/bugsnag_helper'
require 'helpers/json_parser'
require 'helpers/json_formatter'
require 'helpers/error_formatter'

module MyServiceName
  class Web < Grape::API

    helpers RequestMetadataHelper
    helpers LogHelper
    helpers BugsnagHelper

    # https://github.com/ruby-grape/grape#table-of-contents

    content_type    :json_hal, 'application/hal+json'
    parser          :json_hal, JsonParser
    formatter       :json_hal, JsonFormatter
    error_formatter :json_hal, ErrorFormatter
    format          :json_hal
    default_format  :json_hal

    before do
      setup_request_metadata
      setup_logger_request_metadata
      setup_bugsnag_request_metadata

      logger.info "#{env['REQUEST_METHOD']} #{env['REQUEST_URI']}"
    end

    # mount endpoints here

    mount MyServiceName::RootEndpoints
    mount MyServiceName::AddSixEndpoints

    ###

    ::GrapeSwagger.model_parsers.register(
      OatSwagger::GrapeSwaggerParser,
      OatSwagger::Serializer,
    )

    add_swagger_documentation(
      hide_documentation_path: true,
      models: OatSwagger::Serializer.swagger_models,
    )
  end
end
