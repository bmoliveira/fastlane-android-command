# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/android_command/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-android_command'
  spec.version       = Fastlane::AndroidCommand::VERSION
  spec.author        = %q{Bruno Oliveira}
  spec.email         = %q{bm.oliveira.dev@gmail.com}

  spec.summary       = %q{Android Helpers to run commands with adb, emulator and android binaries}
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-android_command"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.104.0'
end
