# frozen_string_literal: true

module Hoverfly
  module Util
    def self.parse_path_from_url(url)
      ParsedPath.new(*url.delete_prefix("/").split("/"))
    end

    def self.parse_params(params)
      Rack::Utils.parse_nested_query(params.to_a.map { |p| p.join("=") }.join("&"))
    end

    ParsedPath = Struct.new(:resource, :id, :sub_command)

    def self.generate_id(resource_prefix)
      "__TEST__#{resource_prefix}__#{SecureRandom.uuid}"
    end

    module LoadFixtures
      def load_fixtures(*args)
        args.each do |arg|
          define_method("#{arg}_fixture") do
            instance_variable_get("@#{arg}_fixture") ||
              instance_variable_set("@#{arg}_fixture", JSON.parse(File.read("#{File.dirname(__FILE__)}/fixtures/#{arg}.json")))
          end
        end
      end
    end
  end
end
