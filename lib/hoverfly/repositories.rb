module Hoverfly
  class Repositories
    def self.add_repositories(*args)
      args.each do |arg|
        define_method(arg) do
          instance_variable_get("@#{arg}") || instance_variable_set("@#{arg}", {})
        end
      end
    end

    add_repositories :customers,
                     :subscriptions
  end
end
