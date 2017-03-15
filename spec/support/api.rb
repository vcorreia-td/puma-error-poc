require 'multi_json'

module MyServiceName
  module Support
    module API
      def parsed_response
        MultiJson.load last_response.body
      end
    end
  end
end
