module MyServiceName
  module RequestMetadataHelper
    extend Grape::API::Helpers

    def setup_request_metadata
      request['talkdesk.platform_tid'] =
        headers['X-Platform-Tid'] || params[:platform_tid] ||
        headers['X-Request-Id'] || SecureRandom.uuid
      request['talkdesk.request_id'] =
        headers['X-Request-Id'] || request['talkdesk.platform_tid']
      request['talkdesk.client_ip'] =
        headers['X-Forwarded-For'] || env['REMOTE_ADDR'] || 'N/A'
      request['talkdesk.account_id'] =
        headers['X-Account-Id'] || request['account_id'] || 'N/A'
      request['talkdesk.account'] = headers['X-Account'] || 'N/A'
      request['talkdesk.user_id'] = headers['X-User-Id'] || 'N/A'
      request['talkdesk.username'] = headers['X-Username'] || 'N/A'
    end
  end
end
