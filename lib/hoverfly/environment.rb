module Hoverfly
  class Environment
    API_VERSION = "v2"

    attr_reader :repositories

    def initialize
      @repositories = Repositories.new
    end
  end
end
