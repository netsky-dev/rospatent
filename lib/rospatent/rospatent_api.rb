require 'net/http'
require 'json'

module Rospatent
  class RospatentAPI
    def self.get_response(path, api_key)
      uri = URI("https://online.rospatent.gov.ru/external_api#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Bearer #{api_key}"
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        raise Error, JSON.parse(response.body)["error"]["message"]
      end
    end
  end

end
