# frozen_string_literal: true

require File.expand_path(File.join('..', 'lib', 'pickynode'), __FILE__)

Gem::Specification.new do |s|
  s.name        = 'pickynode'
  s.version     = Pickynode::VERSION
  s.date        = '2017-05-19'
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
  s.required_ruby_version = '>= 2.0'

  s.add_dependency 'awesome_print', '~> 1.7'
  s.add_dependency 'trollop', '~> 2.1'

  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rubocop', '~> 0.48'
end
