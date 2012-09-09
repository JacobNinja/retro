require File.expand_path('./../test_helper', __FILE__)

class HandlerTest < Test::Unit::TestCase

  test "#response returns client message with header and body if set" do
    mock_handler = Class.new(Retro::Handlers::Handler) do
      @header = "@A"
      @body = "test"
    end
    user = Retro::User.new
    sut = mock_handler.new(user, "data")
    result = sut.call
    assert_instance_of Retro::Client::Message, result
    assert_equal "@A", result.header
    assert_equal "test", result.body
  end

  test "wraps data in server message" do
    sut = Retro::Handlers::Handler.new(stub, "data")
    assert_instance_of Retro::ServerMessage, sut.data
  end

end