class BitArray
  attr_reader :size
  attr_reader :field
  include Enumerable

  VERSION = "1.2.0"
  ELEMENT_WIDTH = 32

  def initialize(size, field = nil)
    @size = size
    @field = field || Array.new(((size - 1) / ELEMENT_WIDTH) + 1, 0)
  end

  # Set a bit (1/0)
  def []=(position, value)
    if value == 1
      @field[position / ELEMENT_WIDTH] |= 1 << (position % ELEMENT_WIDTH)
    elsif (@field[position / ELEMENT_WIDTH]) & (1 << (position % ELEMENT_WIDTH)) != 0
      @field[position / ELEMENT_WIDTH] ^= 1 << (position % ELEMENT_WIDTH)
    end
  end

  # Read a bit (1/0)
  def [](position)
    @field[position / ELEMENT_WIDTH] & 1 << (position % ELEMENT_WIDTH) > 0 ? 1 : 0
  end

  # Iterate over each bit
  def each
    return to_enum unless block_given?
    @size.times { |position| yield self[position] }
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    @field.collect{|ea| ("%0#{ELEMENT_WIDTH}b" % ea).reverse}.join[0..@size-1]
  end
  
  # Iterate over each byte
  def each_byte
    return to_enum(:each_byte) unless block_given?
    @field.each { |byte| yield byte }
  end

  # Returns the total number of bits that are set
  # Use Brian Kernighan's way, see
  # https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan
  def total_set
    @field.each_byte.inject(0) { |a, byte| (a += 1; byte &= byte - 1) while byte > 0 ; a }
  end
end
