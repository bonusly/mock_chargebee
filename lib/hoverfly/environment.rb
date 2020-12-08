module Hoverfly
  class Environment
    API_VERSION = "v2"

    API_RESOURCES = [
      :customers,
      :subscriptions,
    ]

    attr_reader :repositories

    def initialize
      @repositories = Repositories.new(*API_RESOURCES)
    end

    def generate_webhook_event(event_data)
      event_data[:id] ||= new_id "evt"
      @events[event_data[:id]] = symbolize_names(event_data)
    end
  end
end
