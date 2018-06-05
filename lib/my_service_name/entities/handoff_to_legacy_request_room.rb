module MyServiceName
  module DB
    class HandoffToLegacyRequestRoom
      attr_reader :id
      attr_reader :handoff_to_legacy_request_id
      attr_reader :pas_room_id

      def initialize(id:, handoff_to_legacy_request_id:, pas_room_id:)
        @id = id
        @handoff_to_legacy_request_id = handoff_to_legacy_request_id
        @pas_room_id = pas_room_id
      end
    end
  end
end
