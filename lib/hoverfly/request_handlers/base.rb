# frozen_string_literal: true

module Hoverfly
  module RequestHandlers
    class Base
      extend Util::LoadFixtures

      def self.call(http_method, parsed_path, params = {})
        new(http_method, parsed_path, params).call
      end

      def initialize(http_method, parsed_path, params)
        @http_method = http_method
        @parsed_path = parsed_path
        @params = params
        @env = Hoverfly.environment
      end

      private

      attr_reader :http_method, :parsed_path, :params, :env

      delegate :repositories, to: :env
      delegate :id, :sub_command, to: :parsed_path
    end
  end
end
