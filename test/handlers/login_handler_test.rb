require './test_helper'

class LoginHandlerTest < Test::Unit::TestCase

  attr_reader :sut, :session, :user

  def setup
    @session = Retro::Session.new(stub)
    @user = Retro::User.new
    @sut = Retro::Handlers::Login.new(session, "@Dtest@C123")
  end

  test "authenticates with username and password" do
    Retro::UserManager.expects(:authenticate).with("test", "123").returns(user)
    sut.call
  end

  test "sets user on session when successful login" do
    Retro::UserManager.expects(:authenticate).returns(user)
    sut.call
    assert_equal user, session.user
  end

end