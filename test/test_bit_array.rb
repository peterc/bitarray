require "test/unit"

class TestBitArray < Test::Unit::TestCase

  def setup
    @public_bf = BitArray.new(1000)
  end

  def test_basic
    assert_equal 0, BitArray.new(100)[0]
    assert_equal 0, BitArray.new(100)[1]
  end

  def test_setting_and_unsetting
    @public_bf[100] = 1
    assert_equal 1, @public_bf[100]
    @public_bf[100] = 0
    assert_equal 0, @public_bf[100]
  end

  def test_random_setting_and_unsetting
    100.times do
      index = rand(1000)
      @public_bf[index] = 1
      assert_equal 1, @public_bf[index]
      @public_bf[index] = 0
      assert_equal 0, @public_bf[index]
    end
  end

  def test_multiple_setting
    1.upto(999) do |pos|
      2.times { @public_bf[pos] = 1 }
      assert_equal 1, @public_bf[pos]
    end
  end

  def test_multiple_unsetting
    1.upto(999) do |pos|
      2.times { @public_bf[pos] = 0 }
      assert_equal 0, @public_bf[pos]
    end
  end

  def test_size
    assert_equal 1000, @public_bf.size
  end

  def test_to_s
    bf = BitArray.new(10)
    bf[1] = 1
    bf[5] = 1
    assert_equal "0100010000", bf.to_s
  end

  def test_total_set
    bf = BitArray.new(10)
    bf[1] = 1
    bf[5] = 1
    assert_equal 2, bf.total_set
  end
end
