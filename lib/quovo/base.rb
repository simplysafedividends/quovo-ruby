# frozen_string_literal: true

require 'httparty'

require 'quovo/config'

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

      #
      #
      #
      def fetch(method, path, options = {})
        request_options = get_auth_header(path)

        request_options[:body] = options[:body].to_json if options.key?(:body)
        request_options[:headers]['Content-Type'] = 'application/json' if request_options.key?(:body)
        request_options[:debug_output] = $stdout if Quovo.config.verbose

        response = send(method, path, request_options)
        raise_errors_if_needed(response)

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

      #
      #
      #
      #
      def get_auth_header(path)
        if path =~ BASIC_AUTH_PATHS
          # HTTParty-specific config for basic auth
          {
            basic_auth: {
              username: Quovo.config.username,
              password: Quovo.config.password
            }
          }
        else
          { headers: jwt_auth_header }
        end
      end

      #
      #
      #
      def raise_errors_if_needed(response)
        raise Quovo::ApiError, response.body if response.server_error?
        raise Quovo::UnauthorizedError, response.body if response.unauthorized?
      end
    end
  end
end
