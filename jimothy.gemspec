require_relative "lib/jimothy/version"

Gem::Specification.new do |spec|
  spec.name        = "jimothy"
  spec.version     = Jimothy::VERSION
  spec.authors     = ["Mark McDermott"]
  spec.email       = ["mark@markmcdermott.io"]
  spec.homepage    = "https://rubygems.org/gems/jimothy"
  spec.summary     = "Placeholder Rails users from The Office"
  spec.description = "Placeholder Rails users from The Office"
  spec.license     = "MIT"
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4.2"
end
