require 'grape'

module MyServiceName
  module Endpoints
    class Test < Grape::API
      resource :test do
        desc "test endpoint"
        
        params do
          requires :value, type: String, desc: 'some value'
        end
        route_param :value do
          get do
            value = params[:value]
            result = MyServiceName::System[:my_interactor].call(value: value)
            puts result
            status 200
          end
        end
      end

      resource :test_retries do
        desc "test endpoint"
        
        params do
          requires :value, type: String, desc: 'some value'
        end
        route_param :value do
          get do
            value = params[:value]
            result = MyServiceName::System[:my_interactor].call(value: value, mode: 'retries')
            puts result
            status 200
          end
        end
      end
    end
  end
end
