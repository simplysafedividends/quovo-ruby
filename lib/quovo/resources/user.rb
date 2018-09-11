module Quovo
  module Resources
    class User < Base
      class << self
        # Fetches users. Only username searching supported.
        #
        # e.g. Quovo.users.all(username: 'a_username')
        #
        # @param params [Hash]
        # @option username [String]
        # @return [OpenStruct]
        def all(params = {})
          query_params = "?username=#{params[:username]}" if params.present?
          request(:get, "/users#{query_params}")
        end

        # Creates a user.
        #
        # @param username [String]
        # @param email [String]
        # @param name [String]
        # # @return [OpenStruct]
        def create(username: , email: nil, name: nil)
          # As of 2018-09-11 Quovo's api allows one to create a user with a null username, so we're just taking
          # preventative measures
          params = { username: username }
          params[:email] = email if email
          params[:name] = name if name

          request(:post, '/users', body: params)
        end

        # Destroys user.
        #
        # @param id [String]
        def destroy(id)
          request(:delete, "/users/#{id}")
        end

        # Fetches user.
        #
        # @param id [String]
        # @return [OpenStruct]
        def find(id)
          request(:get, "/users/#{id}")
        end

        # Updates a given user.
        #
        # @param id [String]
        # @param params [Hash]
        # @option email [String]
        # @option name [String]
        # @return [OpenStruct]
        def update(id, params = {})
          request(:put, "/users/#{id}", body: params)
        end
      end
    end
  end
end
