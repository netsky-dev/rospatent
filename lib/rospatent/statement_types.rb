require_relative "api_request_decorator.rb"

module Rospatent
  class StatementTypes
    def self.get_statement_types(api_key)
      path = "/statement-types/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_type(api_key, statement_type_id)
      path = "/statement-types/#{statement_type_id}/"
      ApiRequestDecorator.get_response(path, api_key)
    end

    def self.get_statement_type_referred(api_key, statement_type_id)
      path = "/statement-types/#{statement_type_id}/referred/"
      ApiRequestDecorator.get_response(path, api_key)
    end
  end
end
