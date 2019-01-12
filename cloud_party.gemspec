# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_party/version'

spec = Gem::Specification.new do |s|
  s.name          = 'cloud_party'
  s.version       = CloudParty::VERSION
  s.authors       = ['Ken Spencer']
  s.email         = ['me+gems@iotaspencer.me']

  s.summary       = "Thin Ruby wrapper around Cloudflare's V4 API. Based on https://github.com/trev/rubyflare"
  s.description   = "Thin Ruby wrapper around Cloudflare's V4 API for good measure!"
  s.homepage      = 'https://github.com/IotaSpencer/cloud_party'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = %w[lib]

  #  spec.required_ruby_version = '>= 2.3'
  s.add_development_dependency 'bundler', '~> 1.17.2'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.6.0'
  s.add_development_dependency 'debase'
  s.add_development_dependency 'pry', '~> 0.11.3'
  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'ruby-debug-ide', '~> 0.7.0.beta7'
  s.add_development_dependency 'webmock', '~> 2.1'

  s.add_runtime_dependency 'app_configuration'
  s.add_runtime_dependency 'httparty', '~> 0.16.2'
  s.add_runtime_dependency 'rubyflare'
end
# spec