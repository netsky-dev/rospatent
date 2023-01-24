require_relative "api_request_decorator.rb"

module Rospatent
  def self.auth_url
    qs = URI.encode_www_form(
      client_id: configuration.client_id,
      response_type: :code,
      redirect_uri: configuration.redirect_uri,
    )
    "#{AUTH_BASE}/o/authorize/?#{qs}"
  end

  class Authorization
    attr_reader :token
    attr_reader :refresh

    def initialize(token, refresh)
      @token = token
      @refresh = refresh
    end

    def replace_token(token, refresh)
      @token = token
      @refresh = refresh
    end

    def self.authorize(code)
      res = ApiRequestDecorator.post_auth_response(
        grant_type: :authorization_code,
        redirect_uri: Rospatent.configuration.redirect_uri,
        code: code,
        client_id: Rospatent.configuration.client_id,
        client_secret: Rospatent.configuration.client_secret
      )
      Authorization.new(res["access_token"], res["refresh_token"])
    end

    def self.authorize!(data)
      result = self.authorize data
      if result.nil?
        raise Error, "Failed to authorize"
      end

      result
    end
  end
end
