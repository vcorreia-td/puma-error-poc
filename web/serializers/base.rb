require 'grape'

module MyServiceName
  module Serializer
    class Base < OatSwagger::Serializer
      include GrapeRouteHelpers::NamedRouteMatcher

      def item_url(resource:, env:, params: {})
        "#{base_url(env: env)}#{resource_url(resource: resource, params: params)}"
      end

      def base_url(env:)
        request = Grape::Request.new(env)

        host = env['X_FORWARDED_HOST'] || env['HTTP_X_API_BASE'] || "//#{request.host_with_port}"
        scheme = env['X_FORWARDED_PROTO'] || env['HTTP_X_API_SCHEME'] || request.scheme

        "#{scheme}:#{host}"
      end

      private

      def resource_url(resource:, params:)
        # TODO: When generating the url for array parameters here, grape will add [] to the names of
        # arguments, e.g. integration[]=foo . This poses no problem (as we support names both with and
        # without []) but the preferred way is still to not use [], so it would be preferable to not
        # generate links with it.
        send "#{resource}_path", params
      end
    end
  end
end
