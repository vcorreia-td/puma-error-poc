module MyServiceName
  module Helpers
    module Auth
      extend Grape::API::Helpers

      def validate_api_key
        key = headers['X-Api-Key'] || headers['Api-Key'] || params[:api_key]
        match = ENV['API_KEY']

        return if match.nil?
        return if key == match

        error!('Access denied due to invalid key', 401)
      end
    end
  end
end
