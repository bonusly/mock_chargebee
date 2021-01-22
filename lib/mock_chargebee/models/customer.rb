# frozen_string_literal: true

module MockChargebee
  module Models
    class Customer < Base
      RESOURCE_ID_PREFIX = "cust"

      load_fixtures :customer

      def self.find(id)
        repositories.customers.fetch(id)
      end

      def self.create(params)
        params["id"] ||= unique_id
        customer = customer_fixture.merge(params)
        repositories.customers.store(customer["id"], customer)

        customer
      end

      def self.update(id, params)
        customer = find(id)
        customer.merge!(params)
        repositories.customers.store(customer["id"], customer)

        customer
      end
    end
  end
end
