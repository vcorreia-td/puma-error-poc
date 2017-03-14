require 'serializers/base'

module MyServiceName
  class RootSerializer < BaseSerializer
    build_schema do
      schema do
        link :self, href: item_url(resource: :root, env: context)
        link :addsix, href: item_url(resource: :addsix, env: context)
      end
    end
  end
end
