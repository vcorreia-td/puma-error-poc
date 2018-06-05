require 'securerandom'

module MyServiceName
  module Helper
    module IdGenerator
      def self.call
        SecureRandom.hex
      end
    end
  end
end
