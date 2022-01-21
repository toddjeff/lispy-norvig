$: << File.expand_path("lib")

require "lisp/version"

Gem::Specification.new do |s|
  s.name        = "lispy"
  s.version     = Lispy::VERSION
  s.summary     = "whatever"
  s.description = ""
  s.authors     = ["me"]
  s.email       = "me@example.org"
  s.files       = `git ls-files -z`.split("\x0")
  s.test_files  = s.files.grep(%r{^test/})
  s.homepage    = "https://github.com/toddjeff/lisp-norvig"
  s.license     = "MIT"
  s.bindir      = "bin"

  s.executables << "lispy"

  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_dependency 'fisk', '~> 2.3.1'
end
