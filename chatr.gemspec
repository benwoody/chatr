version = File.read(File.expand_path("../chatr_version",__FILE__)).strip

Gem::Specification.new do |s|
  s.name             = 'chatr'
  s.version          = version

  s.summary          = "Simple chat interface using Sockets"
  s.description      = "This gem is for my final project for UW Ruby Certificate course"

  s.authors          = ["Ben Woodall"]
  s.email            = 'mail@benwoodall.com'
  s.homepage         = 'http://github.com/benwoody/chatr'

  s.files            = `git ls-files`.split("\n")
  s.executables      = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths    = ["lib"]

  s.extra_rdoc_files = ["README.md"]

end
