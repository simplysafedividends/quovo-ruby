module Quovo
  module Resources
    class Account < Base
      class << self
        # Fetches all accounts.
        #
        # @return [OpenStruct]
        def all
          request(:get, '/accounts')
        end

        #
        #
        # @return [OpenStruct]
        def find(id)
          request(:get, "/accounts/#{id}")
        end

        #
        #
        # @return [OpenStruct]
        def for_connection(connection_id)
          request(:get, "/connections/#{connection_id}/accounts")
        end

        #
        #
        # @return [OpenStruct]
        def for_user(user_id)
          request(:get, "/users/#{user_id}/accounts")
        end

        # Updates a given account.
        #
        # @param id [Integer]
        # @param params [Hash]
        # @option is_disabled [Boolean] enable/disable the account
        # @option nickname [String]
        # @option type [String] Must be one of types listed here: https://docs.quovo.com/data-dictionary/#account-types
        # @return [OpenStruct]
        def update(id, params = {})
          request(:put, "/accounts/#{id}", body: params)
        end
      end
    end
  end
end
