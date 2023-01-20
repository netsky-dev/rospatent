require_relative "api_request_decorator.rb"

module Rospatent
  class Statements
    def self.get_user_statements(api_key, is_draft: false, page: 1)
      path = "/user-statements/?is_draft=#{is_draft}&page=#{page}"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.create_statement(api_key, payload)
      path = "/statements/"
      ApiRequestDecorator.post_response(path, api_key, payload)
    end

    def self.update_statement(api_key, payload)
      path = "/statements/"
      ApiRequestDecorator.put_response(path, api_key, payload)
    end

    def self.create_statement_publication(api_key, payload)
      path = "/statements/publication/"
      ApiRequestDecorator.post_response(path, api_key, payload)
    end

    def self.get_statement(api_key, statement_id)
      path = "/statements/#{statement_id}/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_attachments(api_key, statement_id)
      path = "/statements/#{statement_id}/attachments/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_events(api_key, statement_id)
      path = "/statements/#{statement_id}/events/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_pdf(api_key, statement_id)
      path = "/statements/#{statement_id}/pdf/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_status(api_key, statement_id)
      path = "/statements/#{statement_id}/status/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_validity(api_key, statement_id)
      path = "/statements/#{statement_id}/validity/"
      ApiRequestDecorator.get_response(path, api_key)
    end
  end
end
