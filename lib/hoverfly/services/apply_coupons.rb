# frozen_string_literal: true

module Hoverfly
  module Services
    class CouponsForSubscription
      def initialize(coupon_ids)
        @coupon_ids = coupon_ids
      end

      def call
        return [] if coupon_ids.empty?

        coupons.map do |coupon|
          {
            "coupon_id" => coupon["id"],
            "apply_till" => apply_till_from(coupon),
            "applied_count" => 1,
            "coupon_code" => nil,
          }
        end
      end

      private

      def coupon_ids
        @coupon_ids || []
      end

      def coupons
        coupon_ids.values.map { |id| Models::Coupon.find(id) }
      end

      def apply_till_from(coupon)
        return nil unless coupon["duration_period"] == "limited_period"

        (Date.today >> coupon["duration_month"]).to_time.to_i
      end
    end
  end
end
