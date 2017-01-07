require_relative 'lib/bitarray'
require 'memory_profiler'

report = MemoryProfiler.report do
    ba = BitArray.new(1000000)

    1000000.times do |i|
      ba[rand(100000)] = 1
      ba[rand(100000)] = 0
    end
end

report.pretty_print
