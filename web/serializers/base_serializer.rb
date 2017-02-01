require 'oat'
require 'oat/adapters/hal'
require 'multi_json'
require 'grape'

module MyServiceName
  class BaseSerializer < Oat::Serializer
    include GrapeRouteHelpers::NamedRouteMatcher

    adapter Oat::Adapters::HAL

    # use class hierarchy shared variable to save all models
    MODELS = Set.new

    def self.swagger_models
      MODELS
    end

    def self.register_swagger_model
      MODELS << self
    end

    def self.properties
      @properties
    end

    def self.property(key, params)
      (@properties ||= {})[key] = params
    end

    def self.collection(key, params)
      property(key, **params, collection: true)
    end

    def self.all_properties
      @all_properties ||= ancestors.each_with_object({}) do |klass, result|
        properties = klass.properties if klass.respond_to?(:properties)
        result.merge!(properties) if properties
      end
    end

    def self.build_schema
      register_swagger_model if all_properties.any?

      schema do
        self.class.all_properties.each do |property_name, property_attributes|
          if property_attributes[:embedded]
            entities property_name, item.send(property_name), property_attributes[:type]
          elsif property_attributes[:extended]
            if property_attributes[:collection]
              property property_name, item.send(property_name).map do |obj|
                property_attributes[:type].new(obj, context).to_hash
              end
            else
              property property_name, property_attributes[:type].new(item.send(property_name), context).to_hash
            end
          else
            map_property property_name
          end
        end
      end

      yield if block_given?
    end

    def to_json(*args)
      MultiJson.dump(to_hash(*args), pretty: true)
    end
  end
end
