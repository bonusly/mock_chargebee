# frozen_string_literal: true

module Hoverfly
  module RequestHandlers
    class Subscriptions < Base
      load_fixtures :subscription,
                    :subscription_create_response

      def call
        send("#{http_method}#{sub_command}")
      end

      private

      def post
        if id.nil?
          subscription, customer = Models::Subscription.create(params)
          subscription_create_response_fixture.merge(subscription: subscription, customer: customer)
        else
          subscription = Models::Subscription.update(id, params)

          { subscription: subscription }
        end
      end

      def get
        subscription = repositories.subscriptions.fetch(id)
        { subscription: subscription }
      end
    end
  end
end
