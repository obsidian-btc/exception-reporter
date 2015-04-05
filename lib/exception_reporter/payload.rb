module ExceptionReporter
  class Payload
    attr_reader :stack_trace

    def self.build(exception)
      p exception
    end

    def set_stack_trace(backtrace)
      @stack_trace = []
      backtrace.each do |line|
        @stack_trace.push(stack_trace_for(line))
      end
    end

    def stack_trace_for(line)
      # see http://www.ruby-doc.org/core-2.0/Exception.html#method-i-backtrace
      file_name, line_number, method = line.split(":")
      {
        lineNumber: line_number,
        fileName:   file_name,
        methodName: method ? method.gsub(/^in `(.*?)'$/, "\\1") : "(none)"
      }
    end

    def hash
      {
        details: {
          error: {
            stackTrace: @stack_trace
          }
        }
      }
    end

    # note lack of "in method name" in this stack trace line
    # assert_equal expected, @client.send(:stack_trace_for, "/some/folder/some_file.rb:123")
  end
end
