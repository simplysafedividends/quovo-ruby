module Quovo
  module Resources
    class User < Base
      class << self

        # Fetches users. Only username searching supported.
        #
        # e.g. Quovo.users.all(username: 'a_username')
        #
        # @param username [String]
        # @return []
        def all(username: nil)
          query_params = "/username=#{username}" if username
          request(:get, "/users#{query_params}")
        end
      end
    end
  end
end
