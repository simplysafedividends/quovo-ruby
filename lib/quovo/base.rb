# frozen_string_literal: true

require 'httparty'

require 'quovo/config'
# require 'quovo/token'
module Quovo
  class Base
    include HTTParty

    base_uri 'https://api.quovo.com/v3'
    headers 'Accept' => 'application/json'

    # Only a handful of Quovo paths use the basic HTTP authorization scheme, the rest use JWT
    BASIC_AUTH_PATHS = /\/(tokens|me)/i

    class << self

      # Makes the actual API request. Proxied by Quovo::Resources::Base for all the resource classes.
      #
      #
      def request(method, path, options = {})
        tries = 0
        loop do
          begin
            break fetch(method, path, options)
          rescue Net::ReadTimeout, Errno::ECONNREFUSED, Net::OpenTimeout => e
            tries += 1
            raise e if tries > Quovo.config.max_retries.to_i
          end
        end
      end

      protected

      def fetch(method, path, options = {})
        request_options = { headers: get_auth_header(path) }
        request_options[:body] = options[:body].to_json if options.key?(:body)
        request_options[:headers]['Content-Type'] = 'application/json' if request_options.key?(:body)
        request_options[:debug_output] = $stdout if Quovo.config.verbose

        response = send(method, path, request_options)

        raise Quovo::ApiError, response.body if !response.success?

        body =
          if response.body.blank?
            response.body
          else
            OpenStruct.new(JSON.parse(response.body.to_s, symbolize_names: true))
          end

        OpenStruct.new(
          body: body,
          headers: response.headers,
          status_code: response.code,
          success?: response.success?
        )
      end

      def get_auth_header(path)
        path =~ BASIC_AUTH_PATHS ? basic_auth_header : jwt_auth_header
      end

      # TODO try https://github.com/jnunemaker/httparty/blob/master/examples/delicious.rb
      def basic_auth_header
        base64 = Base64.encode64("#{Quovo.config.username}:#{Quovo.config.password}").gsub("\n", '')
        { Authorization: "Basic #{base64}" }
      end
    end
  end
end
