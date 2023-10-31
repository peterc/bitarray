require_relative "bit_array"

# Read-only access to a BitArray dumped to disk.
# This is considerably slower than using the RAM-based BitArray, but
# avoids the memory requirements and initial setup time.
class BitArrayFile
  HEADER_LENGTH = BitArray::HEADER_LENGTH

  attr_reader :io, :reverse_byte, :size

  def initialize(filename: nil, io: nil)
    if io
      @io = io
    elsif filename
      @io = File.open(filename, "r")
    else
      raise ArgumentError.new("Must specify a filename or io argument")
    end

    @io.seek(0)
    @size, @reverse_byte = @io.read(9).unpack("QC")
    @reverse_byte = @reverse_byte != 0
  end

  # Read a bit (1/0)
  def [](position)
    seek_to(position >> 3)
    (@io.getbyte & (1 << (byte_position(position) % 8))) > 0 ? 1 : 0
  end

  private def byte_position(position)
    @reverse_byte ? position : 7 - position
  end

  private def seek_to(position)
    @io.seek(position + HEADER_LENGTH)
  end
end
