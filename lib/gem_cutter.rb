require 'net/http'

module GemCutter
  def self.gem_data name
    JSON::parse Net::HTTP.get(URI.parse("http://rubygems.org/api/v1/gems/#{CGI.escape(name)}.json"))
  end
end
