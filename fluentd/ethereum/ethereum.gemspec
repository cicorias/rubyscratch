# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/version'

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-ethereum"
  gem.version       = Ethereum::VERSION
  gem.authors       = ["Shawn Cicoria"]
  gem.email         = ["github@cicoria.com"]

  gem.description   = "Etherum Geth plugin for Fluentd"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/cicorias/fluent-plugin-ethereum"
  gem.licenses      = ["Apache-2.0"]

  gem.has_rdoc    = false

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.test_files  = `git ls-files -- {test,gem,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.bindir        = "exe"
  gem.require_paths = ["lib"]

  gem.add_dependency "fluentd", "~> 0.12"
  gem.add_dependency "em-websocket", "~> 0.5"

  gem.add_development_dependency "bundler", "~> 1.14"
  gem.add_development_dependency "rake", "~> 12.0"
  gem.add_development_dependency "test-unit", "~> 3.0"
  gem.add_development_dependency "test-unit-rr", ">= 1.0.3"
  gem.add_development_dependency "timecop"
  #gem.add_development_dependency "simplecov", ">= 0.5.4"
  #gem.add_development_dependency "rr", ">= 1.0.0"
end
