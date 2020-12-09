# frozen_string_literal: true

module Hoverfly
  module RequestHandlers
    class Subscriptions < Base
      RESOURCE_ID_PREFIX = "sub"

      load_fixtures :subscription,
                    :customer,
                    :subscription_create_response

      def call
        send(http_method)
      end

      private

      def post
        Validations::Subscriptions::CreateParams.validate(params)
        params["id"] ||= Util.generate_id(RESOURCE_ID_PREFIX)
        customer_params = params.delete("customer")
        customer_params["id"] ||= Util.generate_id(Customers::RESOURCE_ID_PREFIX)
        params["customer_id"] = customer_params["id"]

        subscription = subscription_fixture.merge(params)
        customer = customer_fixture.merge(customer_params)

        repositories.subscriptions.store(params["id"], subscription)
        repositories.customers.store(customer["id"], customer)

        subscription_create_response_fixture.merge(subscription: subscription, customer: customer)
      end

      def get
        subscription = repositories.subscriptions.fetch(parsed_path.id)
        { subscription: subscription }
      rescue KeyError
        raise ChargeBee::InvalidRequestError.new(404, message: "#{parsed_path.id} not found")
      end
    end
  end
end
