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
          value =
            if property_attributes[:resolver]&.respond_to?(:call)
              property_attributes[:resolver].call(item: item, context: context)
            else
              item.send(property_name)
            end

          if property_attributes[:embedded] && property_attributes[:collection]
            entities(property_name, value, property_attributes[:type])
          elsif property_attributes[:embedded]
            entity(property_name, value, property_attributes[:type])
          elsif property_attributes[:extended]
            if property_attributes[:collection]
              property(property_name, value.map { |obj|
                property_attributes[:type].new(obj, context).to_hash
              })
            else
              property(property_name, property_attributes[:type].new(value).to_hash)
            end
          else
            property(property_name, value)
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
