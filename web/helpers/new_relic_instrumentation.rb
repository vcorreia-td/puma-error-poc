require 'newrelic_rpm'
require 'grape'

module MyServiceName
  module Helpers
    module NewRelicInstrumentation
      extend Grape::API::Helpers

      def setup_new_relic_instrumentation
        ::NewRelic::Agent.add_custom_attributes(platform_tid: request['talkdesk.platform_tid'])
        ::NewRelic::Agent.add_custom_attributes(account_id: request['talkdesk.account_id'])
        ::NewRelic::Agent.add_custom_attributes(account_name: request['talkdesk.account'])
        ::NewRelic::Agent.add_custom_attributes(client_ip: request['talkdesk.client_ip'])
        ::NewRelic::Agent.add_custom_attributes(user_id: request['talkdesk.user_id'])
        ::NewRelic::Agent.add_custom_attributes(username: request['talkdesk.username'])
      end
    end
  end
end
