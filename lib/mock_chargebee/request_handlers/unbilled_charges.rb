module MockChargebee
  module RequestHandlers
    class UnbilledCharges < Base
      load_fixtures :invoice_unbilled_charges_response

      private

      def post
        Models::Subscription.find(params['subscription_id'])

        invoice_unbilled_charges_response_fixture
      end
    end
  end
end
