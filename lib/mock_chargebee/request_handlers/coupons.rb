# frozen_string_literal: true

module MockChargebee
  module RequestHandlers
    class Coupons < Base
      private

      def post
        coupon = Models::Coupon.create(params)

        { coupon: coupon }
      end
    end
  end
end
