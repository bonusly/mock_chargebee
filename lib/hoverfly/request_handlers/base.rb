module Hoverfly
  module RequestHandlers
    class Base
      def self.call(http_method, url, params = {})
        new(http_method, url, params).call
      end

      def initialize(http_method, url, params)
        @http_method = http_method
        @url = url
        @params = params
        @env = Hoverfly.default_env
      end

      private

      attr_reader :http_method, :url, :params, :env

      delegate :repositories, to: :env
    end
  end
end
