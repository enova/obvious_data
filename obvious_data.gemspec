$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'obvious_data/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'obvious_data'
  s.version     = ObviousData::VERSION
  s.licenses    = ['MIT']
  s.authors     = ['Suan-Aik Yeo']
  s.email       = ['yeosuanaik@gmail.com']
  s.homepage    = 'http://github.com/enova/obvious_data'
  s.summary     = 'Treat DB functions, triggers, etc more like code, and make them more discoverable'
  s.description = 'Rails gem to treat DB functions, triggers, etc more like code, and make them more discoverable'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'railties', '>= 3.2.0', '< 7'
  s.add_dependency 'activerecord', '>= 3.2.0', '< 7'

  s.add_development_dependency 'pg', '< 2'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'coveralls', '~> 0.8'
end
