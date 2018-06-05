module MyServiceName
  module DB
    class HandoffToLegacyRequest
      attr_reader :id
      attr_reader :interaction_id
      attr_reader :rooms

      def initialize(id:, interaction_id:, rooms:)
        @id = id
        @interaction_id = interaction_id
        @rooms = rooms
      end
    end
  end
end
