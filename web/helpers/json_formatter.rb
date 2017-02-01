module MyServiceName
  module JsonFormatter
    def self.call(obj, _env)
      obj.to_json
    end
  end
end
