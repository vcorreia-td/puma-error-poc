require 'time'
require 'my_service_name/log'

module MyServiceName
  module Interactors
    class AddSix
      include Log

      def initialize(_environment)
        # @my_dependency = environment[:my_dependency]
        nil
      end

      def call(number:)
        OpenStruct.new(result: number + 6, at: Time.new)
      end
    end
  end
end
