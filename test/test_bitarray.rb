require "minitest/autorun"
require "bitarray"

class TestBitArray < Minitest::Test
  def setup
    @public_ba = BitArray.new(1000)
  end

  def test_basic
    assert_equal 0, BitArray.new(100)[0]
    assert_equal 0, BitArray.new(100)[99]
  end

  def test_setting_and_unsetting
    @public_ba[100] = 1
    assert_equal 1, @public_ba[100]
    @public_ba[100] = 0
    assert_equal 0, @public_ba[100]
  end

  def test_random_setting_and_unsetting
    100.times do
      index = rand(1000)
      @public_ba[index] = 1
      assert_equal 1, @public_ba[index]
      @public_ba[index] = 0
      assert_equal 0, @public_ba[index]
    end
  end

  def test_multiple_setting
    1.upto(999) do |pos|
      2.times { @public_ba[pos] = 1 }
      assert_equal 1, @public_ba[pos]
    end
  end

  def test_multiple_unsetting
    1.upto(999) do |pos|
      2.times { @public_ba[pos] = 0 }
      assert_equal 0, @public_ba[pos]
    end
  end

  def test_size
    assert_equal 1000, @public_ba.size
  end

  def test_to_s
    ba = BitArray.new(35)
    [1, 5, 6, 7, 10, 16, 33].each{|i|ba[i] = 1}
    assert_equal "01000111001000001000000000000000010", ba.to_s
  end

  def test_field
    ba = BitArray.new(35)
    [1, 5, 6, 7, 10, 16, 33].each{|i|ba[i] = 1}
    assert_equal "0100011100100000100000000000000001000000", ba.field.unpack('B*')[0]
  end

  def test_total_set
    ba = BitArray.new(10)
    ba[1] = 1
    ba[5] = 1
    ba[9] = 1
    assert_equal 3, ba.total_set
  end
end
