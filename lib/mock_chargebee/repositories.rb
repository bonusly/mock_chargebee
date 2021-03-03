# frozen_string_literal: true

module MockChargebee
  class Repositories
    def self.add_repositories(*args)
      args.each do |arg|
        define_method(arg) do
          instance_variable_get("@#{arg}") || instance_variable_set("@#{arg}", RepoHash.new)
        end
      end
    end

    add_repositories :customers,
                     :subscriptions,
                     :coupons,
                     :portal_sessions,
                     :plans,
                     :payment_sources

    class RepoHash < Hash
      def fetch(*)
        super
      rescue KeyError => e
        raise ChargeBee::InvalidRequestError.new(404, message: "#{e.key} not found")
      end
    end
  end
end
