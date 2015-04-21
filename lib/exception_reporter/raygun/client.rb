module ExceptionReporter
  module Raygun
    class Client

      setting :api_key

      attr_reader :payload
      attr_reader :client

      def initialize(payload, client)
        @payload = payload
        @client = client
      end

      def request_payload
        payload.to_json
      end

      def !
        request = client.post('/entries') do |resp|
          puts "got response #{resp.status_code}"
          resp.body_handler do |body|
            puts "The total body received was #{body.length} bytes"
            puts body
          end
        end

        request.put_header('X-ApiKey', api_key)
        request.put_header('Content-Length', request_payload.length.to_json)
        request.put_header('Content-Type', 'application/json')
        puts "Sending a payload!"
        puts request_payload
        request.write_str(request_payload)

        request.end
      end

      def self.build(payload)
        new(payload, client).tap do |instance|
          settings = ExceptionReporter::Settings.instance
          settings.set(instance, 'raygun')
        end
      end

      def self.!(payload)
        logger = Telemetry::Logger.get self
        logger.info "Posting exception: #{payload}"
        instance = build(payload)
        instance.!
      end

      def self.client
        @client ||= Vertx::HttpClient.new.tap do |client|
          logger = Telemetry::Logger.get self
          logger.info "Initializing Client"
          client.host = 'api.raygun.io'
        end
      end
    end
  end
end
