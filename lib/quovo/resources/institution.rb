module Quovo
  module Resources
    class Institution < Base
      class << self
        # Returns the given institution.
        #
        # @param id [String]
        # @return [OpenStruct]
        def find(id)
          request(:get, "/institutions/#{id}")
        end
      end
    end
  end
end
