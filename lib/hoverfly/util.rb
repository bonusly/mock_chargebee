module Hoverfly
  module Util
    def self.parse_path_from_url(url)
      path = URI(url).path.gsub(%r{/api/#{Environment::API_VERSION}/}, "")
      ParsedPath.new(*path.split("/"))
    end

    ParsedPath = Struct.new(:resource, :id, :sub_command)
  end
end
