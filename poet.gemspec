# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "poet/version"

Gem::Specification.new do |s|
  s.name        = "poet"
  s.version     = Poet::VERSION
  s.authors     = ["André Wendt"]
  s.email       = [%w(awendt freeshell.org).join('@')]
  s.homepage    = "https://github.com/awendt/poet"
  s.summary     = %q{Poet concatenates stanzas}
  s.description = %q{Split your longish ~/.ssh/config into files in ~/.ssh/config.d/ and let poet join them for you.}

  s.rubyforge_project = "poet"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "cucumber"
  s.add_development_dependency "aruba"
  s.add_development_dependency "rake"
  s.add_runtime_dependency "thor"
end
