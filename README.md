# Ruby wrapper for Quovo's v3 API (WIP)

## Progress
* `/accounts`
  - Works? Yes
  - Tests? Yes
* `/connections`
  - Works? Yes
  - Tests? Yes
* `/transactions`
  - Works? Yes
  - Tests? Yes
* `/users`
  - Works? Yes
  - Tests? Yes

Endpoints used in Quovo's Connect UI widget (`/auth`, `/challenges`, etc.) may not come any time soon, so if you want
 them, fork and open up a PR for them.

## Requirements
### ruby 2.5.1
Developed on 2.5.1, will probably work on anything 2.3 and above.

### redis
Needed for caching the API's JWT.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'quovo-ruby'
```

Run:
```
bundle
```

Or install it yourself as:
```
gem install quovo-ruby
```
    
Go to wherever your initializers reside and create `quovo.rb`:
```ruby
require 'quovo-ruby'

Quovo.configure do |config|
  # Quovo API dashboard credentials
  config.username = ''
  config.password = ''
  
  # Outputs verbose HTTParty logging to stdout
  config.verbose = true
  
  # redis url for storing JWT
  config.redis_url = 'redis://localhost:6379'
end
````

## Usage
### Users
```ruby
Quovo.users.all
=> #<OpenStruct body=#<OpenStruct users=[{...}, {...}]>, headers={ ... }, status_code=200, success?=true>

Quovo.users.create(username: 'test_username', name: 'John Doe', email: 'test@example.com')
Quovo.users.find(1)
Quovo.users.destroy(1)
Quovo.users.update(1, email: 'new_email@example.com', name: 'John Smith')
```
### Accounts
```ruby
Quovo.accounts.all
Quovo.accounts.find(1)
Quovo.accounts
Quovo.accounts.for_user(2)
Quovo.accounts.for_connection(3)
Quovo.accounts.update(1, {???})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/studentloanbenefits/quovo-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
