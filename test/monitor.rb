require_relative 'test_init'

logger = Logger.register 'Test Output'
bus = Bus.build

monitor = ExceptionReporter::Monitor.start('exception')

Vertx.set_timer(500) do
  bus.publish('exception', {type: 'type', message: 'message', backtrace: 'backtrace'})
end

# ###

# logger.info 'Starting the queue latency telemetry emitter'
# emitter = Bus::Telemetry::QueueLatency::Emitter.start 500

# monitor_name = 'trace and monitor test'
# logger.info 'Starting the queue latency telemetry emitter'
# monitor = Bus::Telemetry::QueueLatency::Monitor.start(monitor_name)

# run_time = 2000
# logger.info "Running the emitter and monitor for #{run_time} milliseconds"
# timer_id = Vertx.set_timer(run_time) do
#   emitter.stop
#   monitor.stop
#   Vertx.cancel_timer timer_id

#   logger.info "Done"
#   Vertx.exit
# end


