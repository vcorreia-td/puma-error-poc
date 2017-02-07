require 'grape'
require 'serializers/error'
require 'serializers/add_six'

module MyServiceName
  class AddSixEndpoints < Grape::API

    resource :addsix do
      desc 'Adds 6 to the received number' do
        success MyServiceName::AddSixSerializer
        failure [
          [400, 'Bad request', MyServiceName::ErrorSerializer]
        ]
      end

      params do
        requires :number, type: Integer, desc: 'A number', allow_blank: false
      end

      post do
        result = System[:add_six].call(number: params[:number])

        status(200) && MyServiceName::AddSixSerializer.new(result, env)
      end
    end
  end
end
