Gem::Specification.new do |s|
  s.name        = 'pickynode'
  s.version     = '0.0.3'
  s.date        = '2017-05-19'
  s.summary     = 'Manage connections to your bitcoin node'
  s.description = 'Some people are picky about the bitcoin nodes they connect to.'
  s.authors     = ['Josh Ellithorpe']
  s.email       = 'quest@mac.com'
  s.homepage    = 'http://github.com/zquestz/pickynode'
  s.license     = 'MIT'
  s.executables << 'pickynode'
  s.add_dependency "awesome_print", "~> 1.7"
  s.add_dependency "trollop", "~> 2.1"
end
