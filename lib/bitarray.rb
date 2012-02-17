class BitArray
  attr_reader :size
  include Enumerable
  VERSION = "0.0.5"

  def initialize(size, default_value = 0)
    @size = size
    @field = default_value == 0 ? 0 : (1<<size)-1
  end

  # Set a bit (1/0)
  def []=(position, value)
    case value
    when 0
      @field ^= 1<<position if @field[position]==1
    when 1
      @field |= 1<<position
    else
      # Undefined, do nothing?
    end
  end

  # Read a bit (1/0)
  def [](position)
    @field[position]
  end

  # Iterate over each bit
  def each(&block)
    @size.times { |position| yield self[position] }
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    s = ''
    @size.times { |i| s<<@field[i]+48 }
    s
  end

  # Returns the total number of bits that are set
  def total_set
    (0...@size).inject(0) { |a,i| a + @field[i] }
  end
end
