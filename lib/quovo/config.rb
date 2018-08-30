require 'ostruct'
require 'redis'

module Quovo
  module Config
    KEYS = %i(redis_url redis username password verbose max_retries).freeze

    attr_writer(*KEYS)

    def redis_url=(url)
      @redis_url = url
      @redis = Redis.new(url: url)
    end

    def configure
      yield self
      self
    end

    def config
      @config ||=
        begin
          hash = KEYS.each_with_object({}) { |key, result| result[key] = instance_variable_get(:"@#{key}") }
          OpenStruct.new(hash)
        end
    end
  end
end
