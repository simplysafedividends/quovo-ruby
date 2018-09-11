
# TODO: peel this back so only the required files are included
require 'active_support/all'

# TODO: pass in environment variable or something so these only load when passed...or figure out a better way
require 'byebug'
require 'awesome_print'

require 'quovo/base'
require 'quovo/config'
require 'quovo/version'

require 'quovo/resources/base'
require 'quovo/resources/account'
require 'quovo/resources/connection'
require 'quovo/resources/transaction'
require 'quovo/resources/user'

module Quovo
  extend Quovo::Config

  class ApiError < StandardError; end
  class UnauthorizedError < StandardError; end

  class << self
    def accounts
      Quovo::Resources::Account
    end

    def connections
      Quovo::Resources::Connection
    end

    def transactions
      Quovo::Resources::Transaction
    end

    def users
      Quovo::Resources::User
    end
  end
end
