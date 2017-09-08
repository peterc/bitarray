class BitArray
  attr_reader :size
  attr_reader :field
  include Enumerable

  VERSION = "1.0.0"

  def initialize(size, field = nil)
    @size = size
    @field = field || "\0" * (size / 8 + 1)
  end

  # Set a bit (1/0)
  def []=(position, value)
    if value == 1
      @field.setbyte(position >> 3, @field.getbyte(position >> 3) | (1 << (position % 8)))
    else
      @field.setbyte(position >> 3, @field.getbyte(position >> 3) ^ (1 << (position % 8)))
    end
  end

  # Read a bit (1/0)
  def [](position)
    (@field.getbyte(position >> 3) & (1 << (position % 8))) > 0 ? 1 : 0
  end

  # Iterate over each bit
  def each(&block)
    @size.times { |position| yield self[position] }
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    @field.bytes.collect{|ea| ("%08b" % ea).reverse}.join[0, @size]
  end

  # Returns the total number of bits that are set
  # (The technique used here is about 6 times faster than using each or inject direct on the bitfield)
  def total_set
    @field.bytes.inject(0) { |a, byte| a += byte & 1 and byte >>= 1 until byte == 0; a }
  end
end
