# frozen_string_literal: true

module MockChargebee
  module Models
    class Base
      def self.repositories
        MockChargebee.environment.repositories
      end

      def self.unique_id
        Util.generate_id(self::RESOURCE_ID_PREFIX)
      end

      def self.already_exists!(id)
        raise ChargeBee::InvalidRequestError.new(400, message: "The value #{id} is already present.")
      end

      def self.load_fixtures(*args)
        args.each do |arg|
          define_singleton_method("#{arg}_fixture") do
            instance_variable_get("@#{arg}_fixture") ||
              instance_variable_set("@#{arg}_fixture",
                                    JSON.parse(File.read("#{File.dirname(__FILE__)}/../fixtures/#{arg}.json")))
          end
        end
      end
    end
  end
end
