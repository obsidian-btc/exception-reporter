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

It is then started (the address that it is listening on is the argument to the `Monitor`) via:

```
ExceptionReporter::Monitor.start('exception')
```

And looks for exceptions with the format of:

```ruby
{
  :time=>"2015-04-06T02:41:00.887Z",
  :type=>'ZeroDivisionError',
  :message=>"divided by 0",
  :backtrace=>[
    "org/jruby/RubyFixnum.java:559:in `/'",
    "(irb):6:in `evaluate'",
    "org/jruby/RubyKernel.java:1101:in `eval'",
    "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/workspace.rb:86:in `evaluate'",
    "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/context.rb:380:in `evaluate'"
  ]
}
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/exception_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
