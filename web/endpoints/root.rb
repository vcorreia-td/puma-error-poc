require 'grape'
require 'serializers/error'
require 'serializers/root'

module MyServiceName
  class RootEndpoints < Grape::API
    desc 'API Root' do
      success MyServiceName::RootSerializer
      failure [
        [400, 'Bad request', MyServiceName::ErrorSerializer]
      ]
    end

    get '/', as: :root do
      result = OpenStruct.new(hello: 'world')

      MyServiceName::RootSerializer.new(result, env)
    end

    route :any, '*path' do
      error!('Bad Request', 400)
    end
  end
end
