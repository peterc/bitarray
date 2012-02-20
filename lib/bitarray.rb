class BitArray
  attr_reader :size
  include Enumerable
  VERSION = "0.0.5"
  ELEMENT_WIDTH = 32

  def initialize(size, default_value = 0)
    @size = size
    default = default_value == 0 ? 0 : (1<<ELEMENT_WIDTH)-1
    max_field_index,last_bit_index = (size-1).divmod(ELEMENT_WIDTH)
    @field = Array.new(max_field_index + 1, default)
    if default_value != 0
      @field[max_field_index] = (1<<last_bit_index+1)-1
    end
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
  def each(&block)
    @size.times { |position| yield self[position] }
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    @field.collect{|ea| ("%032b" % ea).reverse}.join[0..@size-1]
  end

  # Returns the total number of bits that are set
  # (The technique used here is about 6 times faster than using each or inject direct on the bitfield)
  def total_set
    @field.inject(0) { |a, byte| a += byte & 1 and byte >>= 1 until byte == 0; a }
  end
end
