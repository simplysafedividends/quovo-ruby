module Quovo
  module Resources
    class Holding < Base
      class << self
        # Returns holdings for the given account.
        #
        # @param account_id [String]
        # @return [OpenStruct]
        def for_account(account_id)
          request(:get, "/accounts/#{account_id}/holdings")
        end
      end
    end
  end
end