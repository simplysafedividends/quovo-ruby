module Quovo
  module Resources
    class UiToken < Base
      class << self
        # Creates a UI Token.
        #
        # @param user_id [String]
        # @return [OpenStruct]
        def create(user_id:)
          request(:post, "/users/#{user_id}/ui_token")
        end
      end
    end
  end
end