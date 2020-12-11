# frozen_string_literal: true

module Hoverfly
  module Models
    class Subscription < Base
      RESOURCE_ID_PREFIX = "sub"

      load_fixtures :subscription

      def self.create(params)
        Validations::Subscriptions::CreateParams.validate(params)
        params["id"] ||= unique_id

        customer_params = params.delete("customer")
        customer = Customer.create(customer_params)

        params["customer_id"] = customer["id"]

        subscription = subscription_fixture.merge(params)

        repositories.subscriptions.store(params["id"], subscription)

        [subscription, customer]
      end

      def self.update(id, params)
        subscription = repositories.subscriptions.fetch(id)
        subscription.merge!(params)
        repositories.subscriptions.store(subscription["id"], subscription)

        subscription
      end

      def self.create_for_customer(customer, params)
        params["id"] ||= unique_id
        subscription = subscription_fixture.merge(params)
        subscription["customer_id"] = customer["id"]

        repositories.subscriptions.store(subscription["id"], subscription)

        subscription
      end
    end
  end
end
