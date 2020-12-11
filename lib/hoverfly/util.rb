# frozen_string_literal: true

module Hoverfly
  module Util
    def self.parse_path_from_url(url)
      ParsedPath.new(*url.delete_prefix("/").split("/"))
    end

    def self.parse_params(params)
      Rack::Utils.parse_nested_query(params.to_a.map { |p| p.join("=") }.join("&"))
    end

    ParsedPath = Struct.new(:resource, :id, :rest) do
      def sub_command
        rest.nil? ? nil : "_#{rest}"
      end
    end

    def self.generate_id(resource_prefix)
      "__TEST__#{resource_prefix}__#{SecureRandom.uuid}"
    end
  end
end
