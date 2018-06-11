require 'my_service_name/log'

module MyServiceName
  module Interactors
    class MyInteractor
      include Log

      def call(value:, mode: 'default')
        repository = MyServiceName::System[:handoff_to_legacy_request_repository]

        # DOES STUFF

        case mode
        when 'default'
          repository.insert(interaction_id: value, rooms: [value])
        when 'retries'
          repository.insert_with_retries(interaction_id: value, rooms: [value])
        when 'thread'
          repository.insert_and_spawn_reconnect_thread(interaction_id: value, rooms: [value])
        end

        # DOES MORE STUFF
      end
    end
  end
end
