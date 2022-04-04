class BitArray
  attr_reader :size
  attr_reader :field
  include Enumerable

  VERSION = "1.3.0"

  def initialize(size, field = nil, reverse_byte: true)
    @size = size
    @field = field || "\0" * (size / 8 + 1)
    @reverse_byte = reverse_byte
  end

  # Set a bit (1/0)
  def []=(position, value)
    if value == 1
      @field.setbyte(position >> 3, @field.getbyte(position >> 3) | (1 << (byte_position(position) % 8)))
    else
      @field.setbyte(position >> 3, @field.getbyte(position >> 3) & ~(1 << (byte_position(position) % 8)))
    end
  end

  # Read a bit (1/0)
  def [](position)
    (@field.getbyte(position >> 3) & (1 << (byte_position(position) % 8))) > 0 ? 1 : 0
  end

  # Iterate over each bit
  def each
    return to_enum(:each) unless block_given?
    @size.times { |position| yield self[position] }
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    if @reverse_byte
      @field.bytes.collect { |ea| ("%08b" % ea).reverse }.join[0, @size]
    else
      @field.bytes.collect { |ea| ("%08b" % ea) }.join[0, @size]
    end
  end
  
  # Iterates over each byte
  def each_byte
    return to_enum(:each_byte) unless block_given?
    @field.bytes.each{ |byte| yield byte }
  end

  # Returns the total number of bits that are set
  # Use Brian Kernighan's way, see
  # https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan
  def total_set
    @field.each_byte.inject(0) { |a, byte| (a += 1; byte &= byte - 1) while byte > 0 ; a }
  end

  def byte_position(position)
    @reverse_byte ? position : 7 - position
  end
end
