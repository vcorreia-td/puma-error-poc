require 'grape'
require 'serializers/error'
require 'serializers/root'

module MyServiceName
  module Endpoints
    class Root < Grape::API
      desc 'API Root' do
        success Serializers::Root
        failure [
          [400, 'Bad request', Serializers::Error],
        ]
      end

      get '/', as: :root do
        result = OpenStruct.new(hello: 'world')

        Serializers::Root.new(result, env)
      end

      route :any, '*path' do
        error!('Bad Request', 400)
      end
    end
  end
end
