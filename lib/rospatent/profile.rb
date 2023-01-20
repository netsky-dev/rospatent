require_relative "api_request_decorator.rb"

module Rospatent
  class Profile
    def self.get_current_profile(api_key)
      ApiRequestDecorator.get_response("/profiles/current/", api_key)
    end
  end
end
