# frozen_string_literal: true

module Hoverfly
  module Models
    class Customer < Base
      RESOURCE_ID_PREFIX = "cust"

      load_fixtures :customer

      def self.create(params)
        params["id"] ||= unique_id
        customer = customer_fixture.merge(params)
        repositories.customers.store(customer["id"], customer)

        customer
      end
    end
  end
end
