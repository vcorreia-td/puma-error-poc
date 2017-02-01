require 'serializers/error_serializer'

module MyServiceName
  module ErrorFormatter
    def self.call(message, _backtrace, _options, _env)
      ErrorSerializer.new(OpenStruct.new(error: message)).to_json
    end
  end
end
