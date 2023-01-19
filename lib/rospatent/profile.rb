require_relative 'rospatent_api.rb'

module Rospatent
  class Profile
    def self.get_current_profile(api_key)
      RospatentAPI.get_response("/profiles/current/", api_key)
    end
  end
 
end