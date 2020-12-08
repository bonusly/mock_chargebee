module Hoverfly
  module Request
    def self.request(method, url, _env, params = {}, _headers = {})
      parsed_path = Util.parse_path_from_url(url)

      handler = Hoverfly.const_get("RequestHandlers::#{parsed_path.resource.capitalize}")
      handler.call(method, parsed_path, params)
    rescue NameError => e
      raise Hoverfly::MissingRequestHandler parsed_path.resource if e.message.match?(/uninitialized constant/)

      raise e
    end
  end
end
