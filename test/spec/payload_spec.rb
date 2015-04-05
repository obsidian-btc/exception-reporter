require_relative './spec_helper'

describe ExceptionReporter::Payload do

  it 'builds from a message' do
    expect {ExceptionReporter::Payload.build(exception)}.to_not raise_error
  end

  it 'formats a backtrace' do
    payload = ExceptionReporter::Payload.new(exception[:class], exception[:message], backtrace)

    expect(payload.hash[:details][:error][:stackTrace]).to eq([
            { lineNumber: "123",  fileName: "/some/folder/some_file.rb", methodName: "some_method_name" },
            { lineNumber: "1234", fileName: "/another/path/foo.rb",      methodName: "block (3 levels) run"}])
  end

  def exception
    {:class=>ZeroDivisionError, :message=>"divided by 0", :backtrace=>["org/jruby/RubyFixnum.java:559:in `/'", "(irb):6:in `evaluate'", "org/jruby/RubyKernel.java:1101:in `eval'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/workspace.rb:86:in `evaluate'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/context.rb:380:in `evaluate'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:159:in `eval_input'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:273:in `signal_status'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:156:in `eval_input'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/ruby-lex.rb:247:in `each_top_level_statement'", "org/jruby/RubyKernel.java:1501:in `loop'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/ruby-lex.rb:233:in `each_top_level_statement'", "org/jruby/RubyKernel.java:1264:in `catch'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/2.0/irb/ruby-lex.rb:232:in `each_top_level_statement'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:155:in `eval_input'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:70:in `start'", "org/jruby/RubyKernel.java:1264:in `catch'", "/Users/litch/.rbenv/versions/jruby-1.7.15/lib/ruby/1.9/irb.rb:69:in `start'", "/Users/litch/.rbenv/versions/jruby-1.7.15/bin/irb:13:in `(root)'"]}
  end

  def backtrace
    ["/some/folder/some_file.rb:123:in `some_method_name'",
     "/another/path/foo.rb:1234:in `block (3 levels) run'"]
  end

end
