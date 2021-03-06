require 'my_service_name/log'

require 'dry-container'

module MyServiceName
  extend self

  def dependencies(container: Dry::Container.new, eagerly_initialize: true)
    # https://github.com/dry-rb/dry-container

    # require 'my_dependency_here'

    require 'my_service_name/interactors/add_six'
    require 'my_service_name/interactors/my_interactor'
    require 'my_service_name/repositories/handoff_to_legacy_request_repository'    

    # When to use memoize?
    # Memoize should be used when registering thread-safe instances, so they
    # can be (and will be) reused by all threads. This means that you
    # **MUST NOT** add non-thread-safe instances as memoized instances, or there
    # will be fireworks.
    #
    # When instances have non-thread-safe internal state, we register instead
    # factory classes, which can be used to generate instances that will be
    # private to their creator.

    # register containers here

    container.register(:env) {
      ENV
    }

    container.register(:add_six, memoize: true) {
      Interactors::AddSix.new(container)
    }

    container.register(:my_interactor, memoize: true) {
      Interactors::MyInteractor.new
    }

    container.register(:handoff_to_legacy_request_repository, memoize: true) {
      Repository::HandoffToLegacyRequestRepository.new
    }

    eagerly_initialize(container) if eagerly_initialize

    container
  end

  def eagerly_initialize(container)
    container.each_key do |dependency|
      container.resolve(dependency)
    end
  end
end
