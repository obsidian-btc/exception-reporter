require './prox_gem'
ENV['PROX_GEM_MODE'] = 'path'
ENV['PROX_GEM_DIR'] = File.expand_path(File.join(File.dirname(__FILE__), '..', 'libraries'))

source 'https://rubygems.org'

# Specify your gem's dependencies in exception_reporter.gemspec
gemspec

prox_gem 'dependency'
prox_gem 'logger'
prox_gem 'attribute'
prox_gem 'null_attr'
prox_gem 'clock'
prox_gem 'bus'
prox_gem 'settings'

gem 'rspec', '~> 3.2.0'
