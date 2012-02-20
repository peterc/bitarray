require 'bitarray/numeric'
require 'bitarray/string'

class BitArray
  attr_reader :ba
  @@implementation_class = BitArray::Numeric
  VERSION = "0.0.5"

  def initialize(size, default_value = 0)
    @ba = @@implementation_class.new(size, default_value)
  end

  def size
    @ba.size
  end

  # Set a bit (1/0)
  def []=(position, value)
    @ba[position]=value
  end

  # Read a bit (1/0)
  def [](position)
    @ba[position]
  end

  # Iterate over each bit
  def each(&block)
    @ba.each(block)
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    @ba.to_s
  end

  # Returns the total number of bits that are set
  def total_set
    @ba.total_set
  end
end
