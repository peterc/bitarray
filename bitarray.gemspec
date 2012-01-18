# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bit_array"

Gem::Specification.new do |s|
  s.name = "bitarray"
  s.version = BitArray::VERSION
  s.authors = ["Peter Cooper"]
  s.email = ["git@peterc.org"]
  s.homepage = "https://github.com/mceachen/bit-array/"
  s.summary = %q{A fast(ish), pure Ruby bit field "type"}
  s.description = %q{Rubygem packaging of Peter Cooper's BitArray class'}

  s.rubyforge_project = "bitarray"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
  s.add_development_dependency "test-unit"
end
