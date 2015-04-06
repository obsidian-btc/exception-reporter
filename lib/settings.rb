class Settings < ::Settings
  def self.instance
    @instance ||= build
  end

  def self.pathname
    "settings/exception_reporter.json"
  end
end
