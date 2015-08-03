# Schash [![Build Status](https://travis-ci.org/ryotarai/schash.svg?branch=master)](https://travis-ci.org/ryotarai/schash) [![Gem Version](https://badge.fury.io/rb/schash.svg)](http://badge.fury.io/rb/schash)

Pronounciation: the same as "squash"

Ruby hash validator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schash'
```

And then execute:

    $ bundle

## Usage

```ruby
validator = Schash::Validator.new do
  {
    nginx: {
      user: string, # required field
      worker_processes: optional(integer), # optional field
      sites: array_of({
        server_name: string,
        root: string,
        allowed_ips: array_of(string),
      }),
      listen: match(/^(80|443)$/),
    },
  }
end

# valid example
valid = {
  nginx: {
    user: "www-data",
    worker_processes: 4,
    sites: [{
      server_name: "example.com",
      root: "/var/www/itamae",
      allowed_ips: ["127.0.0.1/32"],
    }],
    listen: "80"
  },
}

validator.validate(valid) # => []

# invalid example
invalid = {
  nginx: {
    user: 123,
    sites: {
      server_name: "example.com",
      root: "/var/www/itamae",
      allowed_ips: ["127.0.0.1/32"],
    },
    listen: "8080"
  },
}

validator.validate(invalid)
# => [#<struct Schash::Schema::Error position=["nginx", "user"], message="is not String">, #<struct Schash::Schema::Error position=["nginx", "sites"], message="is not an array">, #<struct Schash::Schema::Error position=["nginx", "listen"], message="does not match /^(80|443)$/">]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/ryotarai/schash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
