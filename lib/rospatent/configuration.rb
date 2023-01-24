module Rospatent
    class Configuration
        attr_accessor :client_id
        attr_accessor :client_secret
        attr_accessor :redirect_uri

        def initialize
            @client_id = nil
            @client_secret = nil
            @redirect_uri = nil
        end
    end
end
