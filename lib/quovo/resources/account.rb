module Quovo
  module Resources
    class Account < Base
      class << self
        def all
          request(:get, '/accounts')
        end

        def find(id)
          request(:get, "/accounts/#{id}")
        end

        def for_user(user_id)
          request(:get, "/users/#{user_id}/accounts")
        end

        def for_connection(connection_id)
          request(:get, "/connections/#{connection_id}/accounts")
        end

        # TODO
        def update(id)
        end
      end
    end
  end
end
