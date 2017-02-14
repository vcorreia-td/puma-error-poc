require 'bugsnag'

module MyServiceName
  module BugsnagHelper
    extend Grape::API::Helpers

    def setup_bugsnag_request_metadata
      Bugsnag.before_notify_callbacks <<
        lambda do |notif|
          notif.user = {id: request['talkdesk.account_id']}

          notif.add_tab(
            :request,
            platform_tid: request['talkdesk.platform_tid'],
            request_id:   request['talkdesk.request_id'],
            account_id:   request['talkdesk.account_id'],
            user_id:      request['talkdesk.user_id'],
            username:     request['talkdesk.username'],
            account:      request['talkdesk.account'],
          )
        end
    end
  end
end
