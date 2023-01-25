require_relative "rospatent/api_request_decorator"
require_relative "rospatent/profile"
require_relative "rospatent/statements"
require_relative "rospatent/statement_types"
require_relative "rospatent/auth"
require_relative "rospatent/configuration"

module Rospatent
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
