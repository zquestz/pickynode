# frozen_string_literal: true

require File.expand_path(File.join('..', 'lib', 'pickynode'), __FILE__)

Gem::Specification.new do |s|
  s.name        = 'pickynode'
  s.version     = Pickynode::VERSION
  s.summary     = 'Manage connections to your bitcoin node'
  s.description = "Some people are picky about the \
bitcoin nodes they connect to."
  s.authors     = ['Josh Ellithorpe']
  s.email       = 'quest@mac.com'
  s.homepage    = 'http://github.com/zquestz/pickynode'
  s.license     = 'MIT'
  s.executables << 'pickynode'
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.5'

  s.add_dependency 'awesome_print', '> 1.7'
  s.add_dependency 'base64'
  s.add_dependency 'optimist', '> 3.0'
  s.add_dependency 'ostruct'

  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rubocop', '~> 0.48'
  s.add_development_dependency 'simplecov', '~> 0.14'
end
