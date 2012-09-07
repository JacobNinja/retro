require File.expand_path('./../../test_helper', __FILE__)

class LoginHandlerTest < Test::Unit::TestCase

  attr_reader :sut, :session, :user

  def setup
    @session = Retro::Session.new(stub)
    @user = Retro::User.new
    @sut = Retro::Handlers::Login.new(session, "@Dtest@C123")
  end

  test "authenticates with username and password" do
    sut.expects(:get_authenticated_user).with("test", "123").returns(user)
    sut.call
  end

  test "successful login" do
    sut.expects(:get_authenticated_user).returns(user)
    sut.call
    assert_equal user, session.user
  end

end