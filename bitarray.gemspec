# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'bitarray'

Gem::Specification.new do |s|
  s.name        = "bitarray"
  s.version     = BitArray::VERSION
  s.authors     = ["Peter Cooper"]
  s.email       = ["git@peterc.org"]
  s.homepage    = "https://github.com/peterc/bitarray"
  s.summary     = %q{A simple, pure Ruby bit-array / bitfield implementation.}
  s.description = %q{A simple, pure Ruby bit-array / bitfield implementation.}
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
end
