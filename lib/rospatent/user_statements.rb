require_relative "api_request_decorator.rb"

module Rospatent
  class UserStatements
    def self.get_user_statements(api_key, is_draft: false, page: 1)
      path = "/user-statements/?is_draft=#{is_draft}&page=#{page}"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_user_statement(api_key, statement_id)
      path = "/user-statement/#{id}"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_user_statement_pay(api_key, statement_id)
      path = "/user-statement-pay/#{id}"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_download_attachment(api_key)
      path = "/download-attachment/"
      ApiRequestDecorator.get_response(path, api_key)
    end
  end
end
