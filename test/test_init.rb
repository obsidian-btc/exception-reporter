ENV['CONSOLE_DEVICE'] = 'stdout'
ENV['LOG_LEVEL'] = 'trace'

begin
  require 'vertx'
rescue  LoadError
  p "Unable to load vertx in this environment"
end

require_relative '../init.rb'
