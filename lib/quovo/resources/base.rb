require 'quovo/api'

module Quovo
  module Resources
    class Base
      class << self
        # Proxy for resource classes.
        def request(*args)
          Quovo::API.request(*args)
        end
      end
    end
  end
end
