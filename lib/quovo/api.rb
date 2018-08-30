require 'quovo/token'

module Quovo
  # A proxy class between Quovo::Base and the resource classes. Handles token refreshing.
  class API < Base

    class << self

      # Proxy between Quovo::Resources::Base.request and Qovo::Base.request. Handles token refreshing if needed.
      def request(*args)
        response = super(*args)

        return response if response.status_code != 401

        Quovo::Token.refresh
        super(*args)
      end

      protected

      # Used in all non-basic HTTP auth calls (which is most of them).
      def jwt_auth_header
        { Authorization: "Bearer #{Quovo::Token.get}" }
      end
    end
  end
end
