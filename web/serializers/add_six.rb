require_relative 'base_serializer'

module MyServiceName
  class AddSixSerializer < BaseSerializer
    property :result, type: Integer, desc: 'Result of adding 6 to a number', required: true

    # Due to the way the base serializer integrates with Oat & swagger
    # this must be always called on all serializers
    build_schema
  end
end
