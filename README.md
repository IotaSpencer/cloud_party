# CloudParty
HTTParty based library for Cloudflare


### Badges
[![Gem Version](https://badge.fury.io/rb/cloud_party.svg)](https://badge.fury.io/rb/cloud_party)
[![Code Climate](https://codeclimate.com/github/IotaSpencer/cloud_party/badges/gpa.svg)](https://codeclimate.com/github/IotaSpencer/cloud_party)
[![Test Coverage](https://codeclimate.com/github/IotaSpencer/cloud_party/badges/coverage.svg)](https://codeclimate.com/github/IotaSpencer/cloud_party/coverage)
[![Build Status](https://travis-ci.org/IotaSpencer/cloud_party.svg?branch=master)](https://travis-ci.org/IotaSpencer/cloud_party)


## Installation

Add this line to your application's Gemfile:

```
gem 'cloud_party'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install cloud_party
```

## Usage

First off, open https://api.cloudflare.com/ to see all the available endpoints

### Quick start

#### Setup connection

Two configurations are applicable for setup currently,


<details>
  <summary>$HOME/.cloud_party/config or /etc/cloud_party/config</summary>
    <p markdown="1">

```yaml
email: 'email@here.com'
api-key: 'abcdefabcdef1234561234567890'
token: 'ABCDEFG123456789ABCDEF
```
</p>
</details>

```ruby
require 'cloud_party'
connection = 
```

#### GET your user account details

```ruby
 user = connection.get('user')

# Read the first result
p user.result

# Read your first name
p user.result[:first_name]
```

#### Update(PATCH) your user account

```ruby
user = connection.patch('user', { first_name: 'Bear' })

# Read the first result
p user.result
```

#### GET all your zones

```ruby
zones = connection.get('zones')

# Read the first zone
p zones.result

# Read the array of zones. Pluralize #result
p zones.results
```

#### Create(POST) a new zone (domain)

```ruby
zone = connection.post('zones', { name: 'supercooldomain.com' })

# Check it out
p zone.result
```

#### Add(POST) an A Record to the zone

```ruby
dns_record = connection.post('zones/#!{#zone.result[:id]}/dns_records', {
                             type: 'A',
                             name: 'supercooldomain.com',
                             content: '127.0.0.1'
                             })

# Check it out
p dns_record.result
```

#### DELETE a zone

```ruby
deleted_zone = connection.delete('zones/#!{zone.result[:id]}')

# Check out the response
p deleted_zone
```

#### Catch errors

```ruby
begin
  connection.get('user')
rescue => e
  # Inspect e.response for more details
  p e.response
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trev/rubyflare. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## Legal

cloud_party, its developers, and other collaborators are not affiliated with nor endorsed by Cloudflare unless explicitly
noted
## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
