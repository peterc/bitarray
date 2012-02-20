require 'benchmark'
require "bitarray"
require "bitarray/numeric"
require "bitarray/string"

@klass = BitArray


def bm_random_set(size)
  ba = @klass.new(size)
  (size/2).times do
    index = rand(size)
    ba[index] = 1
    index = rand(size)
    ba[index] = 0
  end
end

def bm_to_s(size)
  ba = @klass.new(size)
  2.times do
    index = rand(size)
    ba[index] = 1
  end
  ba.to_s
end

def bm_total_set(size)
  ba = @klass.new(size)
  2.times do
    index = rand(size)
    ba[index] = 1
  end
  ba.total_set
end

def bm_default_1(size)
  ba = @klass.new(size, 1)
end

n = 100
s = 100000
puts "n = #{n} ; s = #{s}"
Benchmark.bm(12) do |x|
  x.report("random set:") { n.times{ bm_random_set(s) } }
  x.report("to_s:")       { n.times{ bm_to_s(s)       } }
  x.report("total set:")  { n.times{ bm_total_set(s)  } }
  x.report("default 1:")  { n.times{ bm_default_1(s)  } }
end

