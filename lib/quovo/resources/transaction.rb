module Quovo
  module Resources
    class Transaction < Base
      class << self
        #
        #
        #
        def find(id)
          request(:get, "/transactions/#{id}")
        end

        #
        #
        #
        def for_account(account_id)
          request(:get, "/accounts/#{account_id}/transactions")
        end

        #
        #
        #
        def for_user(user_id)
          request(:get, "/users/#{user_id}/transactions")
        end

        #
        #
        #
        def for_connection(connection_id)
          request(:get, "/connections/#{connection_id}/transactions")
        end

        # TODO
        def update(id)
        end
      end
    end
  end
end
