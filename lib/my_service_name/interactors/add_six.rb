require 'my_service_name/log'

module MyServiceName
  module Interactor
    class AddSix
      include Log

      def initialize(_environment)
      end

      def call(number:)
        OpenStruct.new(result: number + 6)
      end
    end
  end
end
