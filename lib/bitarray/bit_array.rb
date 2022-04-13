class BitArray
  attr_reader :field, :reverse_byte, :size
  include Enumerable

  VERSION = "1.4.0"
  HEADER_LENGTH = 8 + 1 # QC (@size, @reverse_byte)

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

  def ==(rhs)
    @size == rhs.size && @reverse_byte == rhs.reverse_byte && @field == rhs.field
  end

  # Allows joining (union) two bitarrays of identical size.
  # The resulting bitarray will contain any bit set in either constituent arrays.
  # |= is implicitly defined, so you can do source_ba |= other_ba
  def |(rhs)
    raise ArgumentError.new("Bitarray sizes must be identical") if @size != rhs.size
    raise ArgumentError.new("Reverse byte settings must be identical") if @reverse_byte != rhs.reverse_byte

    combined = BitArray.new(@size, @field, reverse_byte: @reverse_byte)
    rhs.field.each_byte.inject(0) do |byte_pos, byte|
      combined.field.setbyte(byte_pos, combined.field.getbyte(byte_pos) | byte)
      byte_pos + 1
    end

    combined
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

  private def byte_position(position)
    @reverse_byte ? position : 7 - position
  end

  # Save contents to an io device such as a file
  def dump(io)
    io.write([@size, @reverse_byte ? 1 : 0].pack("QC"))
    io.write(@field.b)
    io
  end

  # Load bitarray from an io device such as a file
  def self.load(io)
    size, reverse_byte = io.read(9).unpack("QC")
    field = io.read
    new(size, field, reverse_byte: reverse_byte == 1)
  end
end
