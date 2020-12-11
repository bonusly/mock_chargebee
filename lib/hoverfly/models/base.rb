# frozen_string_literal: true

module Hoverfly
  module Models
    class Base
      extend Util::LoadFixtures

      def self.repositories
        Hoverfly.environment.repositories
      end

      def self.unique_id
        Util.generate_id(self::RESOURCE_ID_PREFIX)
      end
    end
  end
end
