require "net/http"
require "json"

module Rospatent
  EXTERNAL_BASE = "https://online.rospatent.gov.ru/external_api"
  AUTH_BASE = "https://online.rospatent.gov.ru"
  #AUTH_BASE = "http://localhost:2280/"

  class ApiRequestDecorator
    def self.make_request(base, path, api_key, request_type, payload = nil, content_type = :json)
      uri = URI("#{base}#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request_class = Net::HTTP.const_get(request_type)
      request = request_class.new(uri)

      if !api_key.nil?
        request["Authorization"] = "Bearer #{api_key}"
      end

      case content_type
      when :form
        request["Content-Type"] = "application/x-www-form-urlencoded"
        request.body = URI.encode_www_form payload if payload
      when :json
        request["Content-Type"] = "application/json"
        request.body = payload.to_json if payload
      else
        raise Error, "make_request accepts only :json and :form for the content_type parameter"
      end

      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        puts response
        raise Error, JSON.parse(response.body)["error"]["message"]
      end
    end

    def self.get_response(path, api_key)
      make_request(EXTERNAL_BASE, path, api_key, "Get")
    end

    def self.post_response(path, api_key, payload)
      make_request(EXTERNAL_BASE, path, api_key, "Post", payload)
    end

    def self.put_response(path, api_key, payload)
      make_request(EXTERNAL_BASE, path, api_key, "Put", payload)
    end

    def self.post_auth_response(payload)
      make_request(AUTH_BASE, "/o/token/", nil, "Post", payload, :form)
    end
  end
end
