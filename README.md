# ExceptionReporter

This can be used to register a handler on a Vert.X EventBus for exception reporting.  Exceptions should be published on the EventBus, and this will send them on to [Raygun](raygun.io).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exception_reporter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exception_reporter

## Usage

This library expects a config file in `./settings/exception_reporter.json` with the format:

```json
{
  "raygun": {
    "api_key": "your-api-key"
  }
}
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/exception_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
