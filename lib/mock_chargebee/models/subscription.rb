# frozen_string_literal: true

module MockChargebee
  module Models
    class Subscription < Base
      RESOURCE_ID_PREFIX = "sub"

      load_fixtures :subscription

      def self.find(id)
        repositories.subscriptions.fetch(id)
      end

      def self.create(params)
        Validations::Subscriptions::CreateParams.validate_required(params)
        params["id"] ||= unique_id

        customer_params = params.delete("customer")
        customer = Customer.create(customer_params)

        coupon_ids = params.delete("coupon_ids")
        params["coupons"] = Services::CouponsForSubscription.new(coupon_ids).call

        params["customer_id"] = customer["id"]

        subscription = subscription_fixture.merge(params)

        repositories.subscriptions.store(params["id"], subscription)

        [subscription, customer]
      end

      def self.create_for_customer(customer, params)
        params["id"] ||= unique_id
        subscription = subscription_fixture.merge(params)
        subscription["customer_id"] = customer["id"]

        repositories.subscriptions.store(subscription["id"], subscription)

        subscription
      end

      def self.update(id, params)
        subscription = find(id)
        subscription.merge!(params)
        repositories.subscriptions.store(subscription["id"], subscription)

        subscription
      end

      def self.cancel(id, params)
        subscription = find(id)
        subscription.merge!(params.merge({ "status" => "cancelled", "canceled_at" => Time.now.to_i }))
        repositories.subscriptions.store(subscription["id"], subscription)

        subscription
      end

      def self.reactivate(id, params)
        subscription = find(id)
        subscription.merge!(params.merge({ "status" => "active", "started_at" => Time.now.to_i }))
        repositories.subscriptions.store(subscription["id"], subscription)

        subscription
      end
    end
  end
end
