module Quovo
  module Resources
    class Connection < Base
      class << self
        def all
          request(:get, '/connections')
        end
      end
    end
  end
end
