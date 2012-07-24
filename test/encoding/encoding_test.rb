require File.expand_path('./../../test_helper', __FILE__)

class Base64EncodingTest < Test::Unit::TestCase

  attr_reader :sut

  def setup
    @sut = Retro::Encoding::Base64
  end

  test "#encode" do
    assert_equal "@@", sut.encode(0)
    assert_equal "@D", sut.encode(4)
    assert_equal "Dl", sut.encode(300)
    assert_equal "IX", sut.encode(600)
    assert_equal "NH", sut.encode(5000)
  end

  test "#decode" do
    assert_equal 0, sut.decode("@@")
    assert_equal 4, sut.decode("@D")
    assert_equal 390, sut.decode("FF")
    assert_equal 491, sut.decode("Gk")
    assert_equal 1313, sut.decode("Ta")
  end

end