require_relative 'authenticator'

module MyServiceName
  module Helpers
    module Auth
      extend Grape::API::Helpers

      def validate_api_key
        key = headers['X-Api-Key'] || params[:api_key]
        match = ENV['API_KEYS']

        return if ENV['RACK_ENV'] == 'development'
        return if Authenticator.call(auth_keys: match, submitted_key: key)

        error!('Access denied due to invalid key', 401)
      end
    end
  end
end
