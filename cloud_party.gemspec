# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_party/version'

Gem::Specification.new do |spec|
  spec.name          = 'cloud_party'
  spec.version       = CloudParty::VERSION
  spec.authors       = ['Ken Spencer', 'Trevor Wistaff']
  spec.email         = ['me+gems@iotaspencer.me', 'trev@a07.com.au']

  spec.summary       = %q{Thin Ruby wrapper around Cloudflare's V4 API. Based on https://github.com/trev/rubyflare}
  spec.description   = %q{Thin Ruby wrapper around Cloudflare's V4 API for good measure!}
  spec.homepage      = 'https://github.com/IotaSpencer/cloud_party'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 11.3'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.6.0'

  spec.add_runtime_dependency 'httparty', '~> 0.16.2'
end
