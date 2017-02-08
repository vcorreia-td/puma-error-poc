require_relative 'base_serializer'

module MyServiceName
  class ErrorSerializer < BaseSerializer

    property :error, type: String, desc: 'A descriptive error message', required: true

    build_schema
  end
end
