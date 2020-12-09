# frozen_string_literal: true

module Hoverfly
  module Request
    def self.request(method, url, _env, params = {}, _headers = {})
      parsed_path = Util.parse_path_from_url(url)
      parsed_params = Util.parse_params(params)

      handler = RequestHandlers.const_get(parsed_path.resource.capitalize)
      handler.call(method, parsed_path, parsed_params)
    rescue NameError => e
      raise Hoverfly::MissingRequestHandler parsed_path.resource if e.message.match?(/uninitialized constant #{parsed_path.resource.capitalize}/)

      raise e
    end
  end
end
