require File.expand_path('./../../test_helper', __FILE__)

class VL64EncodingTest < Test::Unit::TestCase

  attr_reader :sut

  def setup
    @sut = Retro::Encoding::VL64
  end

  test "encode" do
    assert_equal "H", sut.encode(0)
    assert_equal "I", sut.encode(1)
    assert_equal "RB", sut.encode(10)
    assert_equal "PY", sut.encode(100)
    assert_equal "XzC", sut.encode(1000)
  end

  test "decode" do
    assert_equal 0, sut.decode("H")
    assert_equal 1, sut.decode("I")
    assert_equal 10, sut.decode("RB")
    assert_equal 100, sut.decode("PY")
    assert_equal 1000, sut.decode("XzC")
  end

end