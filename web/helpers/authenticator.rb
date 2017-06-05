module MyServiceName
  module Helpers
    module Authenticator
      NoApiKeysConfigured = Class.new(StandardError)

      def self.call(auth_keys:, submitted_key:)
        if auth_keys.nil? || auth_keys.empty?
          raise NoApiKeysConfigured, 'Please configure API_KEYS environment variable (see the README.md).'
        end

        submitted_key && !submitted_key.strip.empty? && auth_keys.split(',').include?(submitted_key)
      end
    end
  end
end
