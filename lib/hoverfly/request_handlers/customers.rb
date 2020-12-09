module Hoverfly
  module RequestHandlers
    class Customers < Base
      RESOURCE_ID_PREFIX = "cust"

      def call
        send(http_method)
      end

      private

      def get
        customer = repositories.customers.fetch(parsed_path.id)
        { customer: customer }
      rescue KeyError
        raise ChargeBee::InvalidRequestError.new(404, message: "#{parsed_path.id} not found")
      end
    end
  end
end
