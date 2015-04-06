# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "exception_reporter"
  spec.version       = '0.0.0'
  spec.authors       = ["Justin Litchfield"]
  spec.email         = ["j@obsidianexchange.com"]
  spec.summary       = %q{An exception reporter for Raygun}
  spec.description   = %q{Raygun exception reporter.  Takes exceptions from the EventBus and publishes them to Raygun}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'logger'
  spec.add_dependency 'dependency'
  spec.add_dependency 'null_attr'
  spec.add_dependency 'attribute'
  spec.add_dependency 'settings'

end
