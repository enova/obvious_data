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
  s.summary     = "TODO: Summary of ObviousData."
  s.description = "TODO: Description of ObviousData."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec"
end
