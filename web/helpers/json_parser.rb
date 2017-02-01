module MyServiceName
  module JsonParser
    def self.call(body, _env)
      MultiJson.load(body, symbolize_keys: true)
    end
  end
end
