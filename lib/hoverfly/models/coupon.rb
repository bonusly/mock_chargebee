# frozen_string_literal: true

module Hoverfly
  module Models
    class Coupon < Base
      RESOURCE_ID_PREFIX = "coup"

      load_fixtures :coupon

      def self.find(id)
        repositories.coupons.fetch(id)
      end

      def self.create(params)
        Validations::Coupons::CreateParams.validate(params)

        params["id"] ||= unique_id
        coupon = coupon_fixture.merge(params)
        repositories.coupons.store(coupon["id"], coupon)

        coupon
      end
    end
  end
end
