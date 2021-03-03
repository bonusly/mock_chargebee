module MockChargebee
  module RequestHandlers
    class PaymentSources < Base
      private

      def post
        customer = Models::Customer.find(params['customer_id'])
        payment_source = Models::PaymentSource.create(params)

        { customer: customer, payment_source: payment_source }
      end
    end
  end
end
