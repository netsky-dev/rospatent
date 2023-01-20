require "net/http"
require "json"
require "uri"

module Rospatent
  ROSPATENT_BASE = "https://online.rospatent.gov.ru"

  class AuthSession
    attr_reader :client_id
    attr_reader :client_secret
    attr_reader :redirect_uri
    attr_reader :grant_type
    attr_accessor :code

    def initialize(params)
      @client_id = params.fetch :client_id
      @client_secret = params.fetch :client_secret
      @redirect_uri = params.fetch :redirect_uri
      @grant_type = params.fetch :grant_type
      @code = params.fetch :code
    end
  end

  def self.auth_url_for(client_id, redirect)
    qs = URI.encode_www_form(
      redirect: redirect,
      client_id: client_id,
      response_type: :code,
      redirect_uri: redirect,
    )
    "#{ROSPATENT_BASE}/o/authorize/?#{qs}"
  end

  class Api
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

    def self.authorize(data)
      res = Net::HTTP.post_form(
        URI("#{ROSPATENT_BASE}/o/token/"),
        grant_type: data.grant_type,
        redirect_uri: data.redirect_uri,
        code: data.code,
        client_id: data.client_id,
        client_secret: data.client_secret,
      )
      js = JSON.parse res.body

      Api.new(js["access_token"], js["refresh_token"])
    end

    def self.authorize!(data)
      result = self.authorize data
      if result.nil?
        raise "Failed to authorize"
      end

      result
    end
  end
end
