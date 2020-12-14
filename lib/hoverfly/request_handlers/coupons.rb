# frozen_string_literal: true

module Hoverfly
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
