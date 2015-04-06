require_relative 'test_init'

logger = Logger.register 'Test Output'
bus = Bus.build

logger.info 'Starting the exception reporter monitor test'

logger.info 'Starting the monitor'
monitor = ExceptionReporter::Monitor.start('exception')


logger.info "Sending an exception"
bus.publish('exception', {:time=>"2015-04-06T02:41:00.887Z", :type=>'ZeroDivisionError', :message=>"divided by 0", :backtrace=>["org/jruby/RubyFixnum.java:559:in `/'", "(irb):6:in `evaluate'", "org/jruby/RubyKernel.java:1101:in `eval'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/workspace.rb:86:in `evaluate'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/context.rb:380:in `evaluate'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:159:in `eval_input'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:273:in `signal_status'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:156:in `eval_input'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/ruby-lex.rb:247:in `each_top_level_statement'", "org/jruby/RubyKernel.java:1501:in `loop'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/ruby-lex.rb:233:in `each_top_level_statement'", "org/jruby/RubyKernel.java:1264:in `catch'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/ruby-lex.rb:232:in `each_top_level_statement'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:155:in `eval_input'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:70:in `start'", "org/jruby/RubyKernel.java:1264:in `catch'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:69:in `start'", "/Users/litch/.rbenv/versions/jruby-1.7.15/bin/irb:13:in `(root)'"]})

run_time = 1500
Vertx.set_timer(run_time) do
  logger.info "Done"
  Vertx.exit
end


