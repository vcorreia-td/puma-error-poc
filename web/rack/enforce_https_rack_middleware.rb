require 'multi_json'
require 'bugsnag'

# Rack middleware to throw errors when https is not being used

module MyServiceName
  class EnforceHttpsRackMiddleware

    InsecureRequestError = Class.new(StandardError)

    def initialize(app)
      @app = app
    end

    def call(env)
      if using_https?(env)
        @app.call(env)
      else
        report_issue(env)
        use_https_response(env)
      end
    end

    private

    def using_https?(env)
      protocol(env) == 'https'
    end

    def protocol(env)
      env['HTTP_X_FORWARDED_PROTO']
    end

    def use_https_response(env)
      [
        400,
        {'Content-Type' => 'application/hal+json'},
        [MultiJson.dump({error: "Unsupported protocol '#{protocol(env)}', please switch to https"}, pretty: true)],
      ]
    end

    def report_issue(env)
      Bugsnag.notify(InsecureRequestError.new("Request attempted with protocol '#{protocol(env)}'"))
    end
  end
end
