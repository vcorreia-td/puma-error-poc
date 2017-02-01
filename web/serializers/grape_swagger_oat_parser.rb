module MyServiceName
  class GrapeSwaggerOatParser
    attr_reader :model
    attr_reader :endpoint

    def initialize(model, endpoint)
      @model = model
      @endpoint = endpoint
    end

    def call
      model_documentation(model)
    end

    def model_documentation(model)
      model.all_properties.each_with_object({}) do |(property, details), docs|
        property_docs = {
          desc: details[:desc],
          is_array: !!details[:collection],
          required: !!details[:required],
        }

        type = ::GrapeSwagger::DocMethods::DataType.call(details[:type])

        if ::GrapeSwagger::DocMethods::DataType.primitive?(type) || (type == 'string')
          property_docs[:type] = type
        elsif details[:collection]
          property_docs[:type] = 'array'
          property_docs[:items] = {'$ref' => "#/definitions/#{type}"}
        else
          property_docs[:type] = 'object'
          property_docs['$ref'] = "#/definitions/#{type}"
        end

        docs[property] = property_docs
      end
    end
  end
end
