
class: center, middle

# Handling Database Failures
---

class: middle
# 1. The microservice should realize that the DB is down.
---

class: middle
# 2. The microservice should refuse to perform operations that require the DB
---

class: middle
# 3. The microservice should tell clients that those operations are unavailable
---

class: middle
# 4. The microservice should try to recover and/or call for help
---

class: middle
# The proposed solution:

https://github.com/vcorreia-td/puma-error-poc
---

class: middle
```ruby
class Test < Grape::API

    helpers do
        # Microservice knows if DB is down (#1)
        def repositories_connected?
            repository = MyServiceName::System[:handoff_to_legacy_request_repository]
            repository.connected?
        end
    end

    resource :test_thread do
        before do
            # Refuse to to operation and inform clients (#2 + #3)
            error!('No database Connection', 500) unless repositories_connected?
        end

        route_param :value do
            # do stuff
        end
    end
end  
```
---

class: middle
```ruby
def insert_and_spawn_reconnect_thread(interaction_id:, rooms:, sleep_seconds: 1)
    generated_id = Helper::IdGenerator.call
    logger.info "HandoffToLegacyRequest Repository: insert id='#{generated_id}' " \
        "interaction_id='#{interaction_id}' rooms='#{rooms}'"

    begin
        connection.transaction do |transaction|
            # DO STUFF
        end
    rescue PG::UnableToSend, PG::ConnectionBad, PG::AdminShutdown => e
        async_reconnect sleep_seconds
        raise
    end
end

# Try to recover (#4)
def async_reconnect(sleep_seconds)
    thread = Thread.new do
        loop do
            logger.info 'Trying to reconnect!'
            connection.reset
            break if connection.status == PG::CONNECTION_OK
            sleep sleep_seconds
        end
        logger.info 'Reconnected!! \o/'
    end
end
```
---

class: middle, center
# Questions?
# Suggestions?
---

class: middle, center
# Thank You

