require 'time'

module ExceptionReporter
  class Monitor

    attr_reader :address
    attr_reader :handler_id

    dependency :bus, Bus
    dependency :logger, Telemetry::Logger

    def initialize(address)
      @address = address
    end

    def self.build(address)
      new(address).tap do |instance|
        Bus.configure instance
        Telemetry::Logger.configure instance
      end
    end

    def self.start(address)
      instance = build address
      instance.start
      instance
    end

    def start
      logger.trace "Starting exception reporter (Address: \"#{address}\")"

      @handler_id = bus.handle(address) do |message|
        handle message
      end

      log_msg = "Reporting Exceptions (Address: \"#{address}\","
      log_msg << " Handler ID: #{handler_id})"
      logger.info log_msg

      handler_id
    end

    def handle(message)
      body = message.body
      logger.trace "Handling exception (Message: #{body}, Handler: #{handler_id})"

      payload = ExceptionReporter::Payload.build(body).hash
      ExceptionReporter::Raygun::Client.!(payload)

      logger.debug "Handled exception"
    end

    def stop
      logger.trace "Stopping monitor for \"#{QueueLatency.metric}\" (Handler ID: #{handler_id})"

      bus.unhandle(handler_id)

      log_msg = "No longer monitoring #{QueueLatency.metric} (Resource: \"#{address}\","
      log_msg << " Source #{source}," if source
      log_msg << " Handler ID: #{handler_id})"
      logger.info log_msg
    end
  end
end
