require 'grape'
require 'serializers/error'
require 'serializers/add_six'

module MyServiceName
  module Endpoints
    class AddSix < Grape::API
      resource :addsix do
        desc 'Adds 6 to the received number' do
          success Serializers::AddSix
          failure [
            [400, 'Bad request', Serializers::Error],
          ]
        end

        params do
          requires :number, type: Integer, desc: 'A number', allow_blank: false
        end

        post do
          result = System[:add_six].call(number: params[:number])

          status 200
          Serializers::AddSix.new(result, env)
        end
      end
    end
  end
end
