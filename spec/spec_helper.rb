require 'bundler/setup'
require 'quovo-ruby'

require 'fakeredis/rspec'
require 'vcr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with(:rspec) { |c| c.syntax = :expect }

  config.before(:all) do
    Quovo.configure do |c|
      # If you're writing new request specs, add your creds here so that vcr will generate new fixtures
      c.username = ''
      c.password = ''

      # redis_url doesn't really matter as fakeredis will take over and use an in-memory store
      # c.redis_url = 'redis://localhost:6379'
      c.redis_url = nil
    end
  end

  # vcr will only run when metadata key :vcr is present in describe/context/it declaration
  config.around(:each) do |example|
    example.metadata.key?(:vcr) ? example.run : VCR.turned_off { example.run }
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # name parameter for /tokens has to be generated every time (since we don't persist tokens) so it's ignored in
  # cassettes
  config.default_cassette_options = { match_requests_on: [:method, VCR.request_matchers.uri_without_param(:name)] }

  # Filters out the HTTP Basic Auth header from the vcr cassette fixtures -- don't really like that we have to use the
  # Base64 library, but vcr doesn't have regex matchers for fixtures, and it works so...¯\_(ツ)_/¯
  config.filter_sensitive_data('<HTTP_BASIC_AUTH_HEADER>') do
    "Basic #{Base64.encode64("#{Quovo.config.username}:#{Quovo.config.password}").gsub("\n", '')}"
  end
end
