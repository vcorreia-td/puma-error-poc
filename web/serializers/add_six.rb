require_relative 'base'

module MyServiceName
  class AddSixSerializer < BaseSerializer
    property :result, type: Integer, desc: 'Result of adding 6 to a number', required: true
    property :at,
      type: String,
      desc: 'Result of adding 6 to a number',
      required: true,
      resolver: ->(item:, **_) { item.at.utc.iso8601 }

    # Due to the way the base serializer integrates with Oat & swagger
    # this must be always called on all serializers
    build_schema
  end
end
