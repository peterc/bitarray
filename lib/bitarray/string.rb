class BitArray
class String
  attr_reader :size
  include Enumerable
  VERSION = "0.0.1"

  AND_BITMASK = %w[
    01111111
    10111111
    11011111
    11101111
    11110111
    11111011
    11111101
    11111110
  ].map{|w| [w].pack("b8").getbyte(0) }.freeze
  OR_BITMASK = %w[
    10000000
    01000000
    00100000
    00010000
    00001000
    00000100
    00000010
    00000001
  ].map{|w| [w].pack("b8").getbyte(0) }.freeze

  def initialize(size, default_value = 0)
    @size = size
    byte,bit=(@size-1).divmod(8)
    if default_value == 0
      @field = "\0" * (byte+1)
    else
      @field = "\xff" * (byte+1)
      @field.setbyte(byte,255>>(7-bit))
    end
  end

  # Set a bit (1/0)
  def []=(position, value)
    byte,bit = position.divmod(8)
    case value
    when 0
      @field.setbyte(byte,@field.getbyte(byte) & AND_BITMASK[bit])
    when 1
      @field.setbyte(byte,@field.getbyte(byte) | OR_BITMASK[bit])
    else
      # Undefined, do nothing?
    end
  end

  # Read a bit (1/0)
  def [](position)
    byte,bit = position.divmod(8)
    (@field.getbyte(byte) >> bit) & 1
  end

  # Iterate over each bit
  def each(&block)
    @size.times { |position| yield self[position] }
  end

  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    byte,bit=(@size-1).divmod(8)
    (byte+1).times.inject([]){|aray,i| aray << @field[i].unpack("b#{if i<byte; 8; else; bit+1; end}") }.join('')
  end

  # Returns the total number of bits that are set
  def total_set
    byte,bit = (@size-1).divmod(8)
    @field.each_byte.inject(0) {|sum,v| sum += v&1 and v>>=1 until v==0; sum }
  end

end
end
