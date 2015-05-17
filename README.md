# OmniAuth PG&E

OmniAuth strategy for [PG&E's Share My Data](http://www.pge.com/en/myhome/addservices/sharemydata/vendor/testrequirements/index.page) using OAuth2.

## Usage

Add the strategy to your `Gemfile` alongside OmniAuth:

```ruby
gem 'omniauth'
gem 'omniauth-pge'
```

Then integrate the strategy into your middleware:

```ruby
use OmniAuth::Builder do
  provider :pge, ENV['PGE_CLIENT_ID'], ENV['PGE_CLIENT_SECRET']
end
```

In Rails, you'll want to add to the middleware stack:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :pge, ENV['PGE_CLIENT_ID'], ENV['PGE_CLIENT_SECRET']
end
```

For additional information, refer to the [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

## Contributing

Feedback, feature requests, and fixes are welcomed and encouraged.  Please make appropriate use of [Issues](https://github.com/doomspork/omniauth-pge/issues) and [Pull Requests](https://github.com/omniauth/pge_auth/pulls).  All code should have accompanying tests.

Be sure to familiarize yourself with the [Code of Conduct](CODE_OF_CONDUCT.md).

## License

Please see [LICENSE](LICENSE) for licensing details.
