require 'dependency'
Dependency.activate

require 'logger'
require 'bus'
require 'settings'
require 'clock'

Settings.activate

require 'exception_reporter/monitor'
require 'exception_reporter/payload'
require 'exception_reporter/raygun/client'

module ExceptionReporter
  class Settings < ::Settings
    def self.instance
      @instance ||= build "./settings/exception_reporter.json"
    end
  end
end
