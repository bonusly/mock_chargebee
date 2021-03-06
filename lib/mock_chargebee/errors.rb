# frozen_string_literal: true

module MockChargebee
  class MissingRequestHandler < StandardError
    def initialize(resource_name)
      super("MockChargebee::RequestHandlers::#{resource_name.capitalize} not found. Expected /request_handlers/#{resource_name}.rb to define it.")
    end
  end

  class InvalidEventAttribute < StandardError
    def initialize(attribute)
      super("Attribute #{attribute} is not allowed on Chargebee events")
    end
  end
end
