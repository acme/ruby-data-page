Gem::Specification.new do |s|
  s.name        = "datapage"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Leon Brocard"]
  s.email       = ["acme@astray.com"]
  s.homepage    = "http://github.com/acme/ruby-data-page/"
  s.summary     = "Data::Page helps when paging through sets of results"
  s.description = "Data::Page helps when paging through sets of results"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rake", ">= 0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.rdoc_options = ["--charset=UTF-8"]
end
