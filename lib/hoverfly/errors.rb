module Hoverfly
  class MissingRequestHandler < StandardError
    def initialize(resource_name)
      super("Hoeverfly::RequestHandlers::#{resource_name.capitalize} not found. Expected /request_handlers/#{resource_name}.rb to define it.")
    end
  end
end
