$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "obvious_data/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "obvious_data"
  s.version     = ObviousData::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "Treat DB functions, triggers, etc more like code, and make them more discoverable" 
  s.description = "Treat DB functions, triggers, etc more like code, and make them more discoverable"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
end
