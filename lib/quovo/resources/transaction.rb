module Quovo
  module Resources
    class Transaction < Base
      class << self
        # Fetches the given transaction.
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

        #
        #
        #
        #
        def update(id, params = {})
          request(:put, "/transactions/#{id}", body: params)
        end
      end
    end
  end
end
