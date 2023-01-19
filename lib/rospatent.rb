require_relative 'rospatent_api.rb'
require_relative 'profile.rb'

module Rospatent
  class Error < StandardError; end

  def self.get_current_profile(api_key)
    Rospatent::Profile.get_current_profile(api_key)
  end
end
