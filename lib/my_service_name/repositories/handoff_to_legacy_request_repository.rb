# frozen_string_literal: true

require_relative '../entities/handoff_to_legacy_request'
require_relative '../entities/handoff_to_legacy_request_room'
require_relative '../helpers/id_generator'
require_relative '../log'
require 'pg'

module MyServiceName
  module Repository
    class HandoffToLegacyRequestRepository
      include Log

      TABLE_NAME = 'handoff_to_legacy_requests'
      ROOMS_TABLE_NAME = 'handoff_to_legacy_request_rooms'
      private_constant :TABLE_NAME, :ROOMS_TABLE_NAME

      attr_reader :connection
      private :connection

      def initialize
        db_url = ENV['POSTGRES_DB_URL']
        raise ConfigurationError if db_url.nil?

        @connection = PG::Connection.open(db_url)
      end

      # Default insert
      def insert(interaction_id:, rooms:)
        generated_id = Helper::IdGenerator.call
        logger.info "HandoffToLegacyRequest Repository: insert id='#{generated_id}' " \
          "interaction_id='#{interaction_id}' rooms='#{rooms}'"

        connection.transaction do |transaction|
          insert_query(
            id: generated_id,
            interaction_id: interaction_id,
            transaction: transaction,
          )
          insert_rooms(rooms: rooms, handoff_to_legacy_request_id: generated_id, transaction: transaction)
        end

        generated_id
      end

      # insert "that tries to recconect and run"
      def insert_with_retries(interaction_id:, rooms:, retries: 5, sleep_seconds: 1)
        generated_id = Helper::IdGenerator.call
        logger.info "HandoffToLegacyRequest Repository: insert id='#{generated_id}' " \
          "interaction_id='#{interaction_id}' rooms='#{rooms}'"
        last_error = nil  
        (1..retries).each do |_|
          begin
            connection.transaction do |transaction|
              insert_query(
                id: generated_id,
                interaction_id: interaction_id,
                transaction: transaction,
              )
              insert_rooms(rooms: rooms, handoff_to_legacy_request_id: generated_id, transaction: transaction)
            end
            return generated_id
          rescue PG::UnableToSend, PG::ConnectionBad, PG::AdminShutdown => e
            last_error = e
            logger.info 'Failed to persist. --> Retrying'
            sleep sleep_seconds
            if !connected?
              reconnect
            end
          end
        end
        raise last_error
      end

      # insert and spawn reconnect thread if error
      def insert_and_spawn_reconnect_thread(interaction_id:, rooms:, sleep_seconds: 1)
        generated_id = Helper::IdGenerator.call
        logger.info "HandoffToLegacyRequest Repository: insert id='#{generated_id}' " \
          "interaction_id='#{interaction_id}' rooms='#{rooms}'"

        begin
          connection.transaction do |transaction|
            insert_query(
              id: generated_id,
              interaction_id: interaction_id,
              transaction: transaction,
            )
            insert_rooms(rooms: rooms, handoff_to_legacy_request_id: generated_id, transaction: transaction)
          end
        rescue PG::UnableToSend, PG::ConnectionBad, PG::AdminShutdown => e
          async_reconnect sleep_seconds
          raise
        end
      end

      # Connection Management
      def connected?
        @connection.status == PG::CONNECTION_OK
      end

      def reconnect
        @connection.reset
      end
      
      private

      def async_reconnect(sleep_seconds)
        thread = Thread.new do
          loop do
            logger.info 'Trying to reconnect!'
            reconnect
            break if connected?
            sleep sleep_seconds
          end
          logger.info 'Reconnected!! \o/'
        end
        logger.info "Reconnecting to DB. Launched Thread."
      end

      def insert_rooms(rooms:, handoff_to_legacy_request_id:, transaction:)
        rooms.each do |pas_room_id|
          generated_id = Helper::IdGenerator.call

          logger.info "HandoffToLegacyRequest Repository: insert room id='#{generated_id}' " \
            "handoff_to_legacy_request_id='#{handoff_to_legacy_request_id}' pas_room_id='#{pas_room_id}' "

          insert_room_query(
            id: generated_id,
            handoff_to_legacy_request_id: handoff_to_legacy_request_id,
            pas_room_id: pas_room_id,
            transaction: transaction,
          )
        end
      end

      def insert_query(id:, interaction_id:, transaction:)
        transaction.exec_params(
          "INSERT INTO #{TABLE_NAME} VALUES ($1, $2)",
          [id, interaction_id],
        )
      end

      def insert_room_query(id:, handoff_to_legacy_request_id:, pas_room_id:, transaction:)
        transaction.exec_params(
          "INSERT INTO #{ROOMS_TABLE_NAME} VALUES ($1, $2, $3)",
          [id, handoff_to_legacy_request_id, pas_room_id],
        )
      end
    end
  end
end
