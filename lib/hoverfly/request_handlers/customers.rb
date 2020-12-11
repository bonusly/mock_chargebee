# frozen_string_literal: true

module Hoverfly
  module RequestHandlers
    class Customers < Base
      load_fixtures :customer

      def call
        send("#{http_method}#{sub_command}")
      end

      private

      def post
        customer = Models::Customer.create(params)
        { customer: customer }
      end

      def get
        customer = repositories.customers.fetch(id)
        { customer: customer }
      end

      def post_subscriptions
        customer = repositories.customers.fetch(id)
        subscription = Models::Subscription.create_for_customer(customer, params)

        { subscription: subscription, customer: customer }
      end
    end
  end
end
