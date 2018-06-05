require 'serializers/base'

module MyServiceName
  module Serializers
    class Root < Base
      build_schema do
        schema do
          link :self, href: item_url(resource: :root, env: context)
          link :addsix, href: item_url(resource: :addsix, env: context)
          link :test, href: item_url(resource: :test, env: context)
        end
      end
    end
  end
end
