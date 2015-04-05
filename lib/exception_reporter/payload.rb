module ExceptionReporter
  class Payload
    attr_reader :class_name
    attr_reader :backtrace
    attr_reader :message

    def initialize(class_name, message, backtrace)
      @class_name = class_name
      @message = message
      @backtrace = backtrace
    end

    def self.build(exception)
      class_name = exception[:class_name]
      message =    exception[:message]
      backtrace =  exception[:backtrace]
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

    def error_details
      {
        className:  class_name,
        message:    message.to_s.encode('UTF-16', :undef => :replace, :invalid => :replace).encode('UTF-8'),
        stackTrace: (backtrace || []).map { |line| stack_trace_for(line) }
      }
    end

    def hash
      {
        details: {error: error_details }
      }
    end

    # note lack of "in method name" in this stack trace line
    # assert_equal expected, @client.send(:stack_trace_for, "/some/folder/some_file.rb:123")
  end
end
