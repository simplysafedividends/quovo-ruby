module Quovo
  module Resources
    class Connection < Base
      class << self
        # Fetches all connections.
        #
        # @return [OpenStruct]
        def all
          request(:get, '/connections')
        end

        # Returns the given connection.
        #
        # @param id [String]
        # @return [OpenStruct]
        def find(id)
          request(:get, "/connections/#{id}")
        end

        # Returns connections for the given user.
        #
        # @param user_id [String]
        # @return [OpenStruct]
        def for_user(user_id)
          request(:get, "/users/#{user_id}/connections")
        end
      end
    end
  end
end
