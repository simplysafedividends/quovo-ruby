module Quovo
  class Token < Base
    class << self

      # Retrieve token, refresh if needed.
      def get
        refresh if token_expired?
        redis.get('quovo-token')
      end

      # Fetches a new token from the API and stores it locally in redis.
      def refresh
        # Name doesn't really matter, just can't be whatever the previous token is
        response = request(:post, "/tokens?name=#{SecureRandom.hex}")

        # Default token returned from API expires in an hour
        redis.set('quovo-token-expires-at', 60.minutes.from_now)
        redis.set('quovo-token', response.body.dig(:access_token, :token))
      end

      protected

      def token_expired?
        !(redis.get('quovo-token-expires-at').present? && Time.parse(redis.get('quovo-token-expires-at')).future?)
      end

      def redis
        Quovo.config.redis
      end
    end
  end
end
