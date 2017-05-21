module MyServiceName
  module Helpers
    module Authenticator

      InvalidAuthKeys = Class.new(StandardError)

      def self.call(auth_keys:, submitted_key:)
        raise InvalidAuthKeys if auth_keys.nil? || auth_keys.empty?
        auth_keys.split(',').include?(submitted_key)
      end
    end
  end
end
