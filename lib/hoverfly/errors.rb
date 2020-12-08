module Hoverfly
  class MissingRequestHandler < StandardError
    def initialize(resource_name)
      super("Hoeverfly::RequestHandlers::#{resource_name.capitalize} not found. Expected /request_handlers/#{resource_name}.rb to define it.")
    end
  end

  class ResourceNotDefined < StandardError
    def initialize(resource_name)
      super("It looks like you are trying to access a resource that you haven't defined in environment.rb. Please declare #{resource_name} as an implemented api resource.")
    end
  end
end
