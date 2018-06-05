require 'serializers/error'

module MyServiceName
  module Helpers
    module ErrorFormatter
      def self.call(message, _backtrace, _options, _env, _original_exception)
        Serializers::Error.new(OpenStruct.new(error: message)).to_json
      end
    end
  end
end
