module MyServiceName
  module RequestMetadataHelper
    extend Grape::API::Helpers

    def setup_request_metadata
      setup_platform_id
      setup_request_id
      setup_client_ip
      setup_account_id
      setup_account
      setup_user_id
      setup_username
    end

    def setup_platform_id
      request['talkdesk.platform_tid'] =
        headers['X-Platform-Tid'] || params[:platform_tid] || headers['X-Request-Id'] || SecureRandom.uuid
    end

    def setup_request_id
      request['talkdesk.request_id'] = headers['X-Request-Id'] || request['talkdesk.platform_tid']
    end

    def setup_client_ip
      request['talkdesk.client_ip'] = headers['X-Forwarded-For'] || env['REMOTE_ADDR'] || 'N/A'
    end

    def setup_account_id
      request['talkdesk.account_id'] = headers['X-Account-Id'] || request['account_id'] || 'N/A'
    end

    def setup_account
      request['talkdesk.account'] = headers['X-Account'] || 'N/A'
    end

    def setup_user_id
      request['talkdesk.user_id'] = headers['X-User-Id'] || 'N/A'
    end

    def setup_username
      request['talkdesk.username'] = headers['X-Username'] || 'N/A'
    end
  end
end
