module ExceptionReporter
  module Raygun
    class Client
      attr_reader :payload
      attr_reader :client

      def initialize(payload, client)
        @payload = payload
        @client = client
      end

      def !
        request = client.post('/entries') do |resp|
          puts "got response #{resp.status_code}"
          resp.body_handler do |body|
            puts "The total body received was #{body.length} bytes"
            puts body
          end
        end

        request.put_header('X-ApiKey', 'SomeEvent')
        request.put_header('Accept', 'application/vnd.eventstore.atom+json')
        request.put_header('Content-Length', payload.length)
        request.put_header('Content-Type', 'application/json')
        request.write_str(payload)

        request.end
      end

      def self.!(payload)
        logger = Logger.get self
        logger.info "Posting exception: #{payload}"
        new(payload, client).!
      end

      def self.client
        @client ||= Vertx::HttpClient.new.tap do |client|
          p "Initializing Client"
          client.host = 'api.raygun.io'
          client.ssl = true
        end
      end
    end
  end
end
