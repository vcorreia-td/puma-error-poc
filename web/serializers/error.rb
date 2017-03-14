require_relative 'base'

module MyServiceName
  module Serializer
    class Error < Base

      property :error, type: String, desc: 'A descriptive error message', required: true

      build_schema
    end
  end
end
