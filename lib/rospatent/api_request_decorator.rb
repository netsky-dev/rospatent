require "net/http"
require "json"

module Rospatent
  class ApiRequestDecorator
    def self.make_request(path, api_key, request_type, payload = nil)
      uri = URI("https://online.rospatent.gov.ru/external_api#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request_class = Net::HTTP.const_get(request_type)
      request = request_class.new(uri)
      request["Authorization"] = "Bearer #{api_key}"
      request["Content-Type"] = "application/json"
      request.body = payload.to_json if payload
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        raise Error, JSON.parse(response.body)["error"]["message"]
      end
    end

    def self.get_response(path, api_key)
      make_request(path, api_key, "Get")
    end

    def self.post_response(path, api_key, payload)
      make_request(path, api_key, "Post", payload)
    end

    def self.put_response(path, api_key, payload)
      make_request(path, api_key, "Put", payload)
    end
  end
end
