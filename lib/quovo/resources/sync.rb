module Quovo
  module Resources
    class Sync < Base
      class << self
        # Returns sync status for the given connection
        #
        # @param connection_id [String]
        # @return [OpenStruct]
        def for_connection(connection_id)
          request(:get, "/connections/#{connection_id}/sync")
        end
      end
    end
  end
end
