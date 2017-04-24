require 'newrelic_rpm'

module AppsAPI
  module InstrumentationHelper
    extend Grape::API::Helpers

    def setup_instrumentation
      ::NewRelic::Agent.add_custom_attributes(platform_tid: request['talkdesk.platform_tid'])
      ::NewRelic::Agent.add_custom_attributes(user_id: request['talkdesk.user_id'])
      ::NewRelic::Agent.add_custom_attributes(account_id: request['talkdesk.account_id'])
      ::NewRelic::Agent.add_custom_attributes(client_id: request['talkdesk.client_id'])
    end
  end
end
