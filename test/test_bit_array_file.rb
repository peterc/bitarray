require "minitest/autorun"
require "tempfile"
require_relative "../lib/bitarray"

class TestBitArrayFile < Minitest::Test
  def setup
    ba = BitArray.new(35)
    [1, 5, 6, 7, 10, 16, 33].each { |i| ba[i] = 1}
    @file = Tempfile.new("bit_array_file.dat")
    ba.dump(@file)
    @file.rewind
  end

  def teardown
    @file.close
    @file.unlink
  end

  def test_from_filename
    baf = BitArrayFile.new(filename: @file.path)
    for i in 0...35
      expected = [1, 5, 6, 7, 10, 16, 33].include?(i) ? 1 : 0
      assert_equal expected, baf[i]
    end
  end

  def test_from_io
    baf = BitArrayFile.new(io: @file)
    for i in 0...35
      expected = [1, 5, 6, 7, 10, 16, 33].include?(i) ? 1 : 0
      assert_equal expected, baf[i]
    end
  end
end

class TestBitArrayFileWhenNonReversedByte < Minitest::Test
  def setup
    ba = BitArray.new(35, reverse_byte: false)
    [1, 5, 6, 7, 10, 16, 33].each { |i| ba[i] = 1}
    @file = Tempfile.new("bit_array_file.dat")
    ba.dump(@file)
    @file.rewind
  end

  def teardown
    @file.close
    @file.unlink
  end

  def test_from_filename
    baf = BitArrayFile.new(filename: @file.path)
    for i in 0...35
      expected = [1, 5, 6, 7, 10, 16, 33].include?(i) ? 1 : 0
      assert_equal expected, baf[i]
    end
  end

  def test_from_io
    baf = BitArrayFile.new(io: @file)
    for i in 0...35
      expected = [1, 5, 6, 7, 10, 16, 33].include?(i) ? 1 : 0
      assert_equal expected, baf[i]
    end
  end
end
