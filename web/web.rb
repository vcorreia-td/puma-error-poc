require 'my_service_name'
require 'grape'
require 'grape/route_helpers'
require 'helpers/request_metadata_helper'
require 'helpers/log_helper'
require 'helpers/bugsnag_helper'

module MyServiceName
  class Web < Grape::API

    helpers RequestMetadataHelper
    helpers LogHelper
    helpers BugsnagHelper

    # https://github.com/ruby-grape/grape#table-of-contents

  end
end
