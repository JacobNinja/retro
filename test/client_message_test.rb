require File.expand_path('./../test_helper', __FILE__)

class ClientMessageTest < Test::Unit::TestCase

  test "#header encodes integer to b64" do
    sut = Retro::Client::Message.new(1)
    assert_equal Retro::Encoding::B64.encode(1), sut.header
  end

  test "#header encodes symbol to b64 if mapping exists" do
    sut = Retro::Client::Message.new(:public_key)
    encoded_header = Retro::Encoding::B64.encode(Retro::Handlers.client_headers[:public_key])
    assert_equal encoded_header, sut.header
  end

  test "#header returns if string" do
    sut = Retro::Client::Message.new("@A")
    assert_equal "@A", sut.header
  end

  test "#packet compiles header and body and chr 1" do
    sut = Retro::Client::Message.new("@A")
    sut.add "test"
    expected = ["@A", "test", 1.chr].join
    assert_equal expected, sut.packet
  end

end