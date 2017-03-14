require_relative 'base'

module MyServiceName
  class ErrorSerializer < BaseSerializer

    property :error, type: String, desc: 'A descriptive error message', required: true

    build_schema
  end
end
