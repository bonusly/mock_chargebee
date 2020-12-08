module Hoverfly
  class Repositories
    def initialize(*args)
      args.each do |arg|
        define_method(arg) do
          instance_variable_get("@#{arg}") || instance_variable_set("@#{arg}", {})
        end
      end
    end

    def method_missing(method_name, *args, &block)
      raise Hoverfly::ResourceNotDefined method_name unless Environment::API_RESOURCES.include?(method_name)

      super
    end
  end
end
