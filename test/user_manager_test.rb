require './test_helper'

class UserManagerTest < Test::Unit::TestCase

  attr_reader :room, :user, :sut

  def setup
    @room = RoomFactory.default
    @user = Retro::User.new
    @sut = Retro::UserManager.new(user)
  end

  test "enter sets current room" do
    sut.enter(room, 0)
    assert_equal room, user.current_room
    assert_equal 0, user.current_room_id
  end

  test "enter adds rights if user owns room" do
    room.expects(:owned_by?).with(user).returns(true)
    assert_false user.states.rights?
    sut.enter(room, 0)
    assert_true user.states.rights?
  end

  test "enter does not add rights if user does not own room" do
    room.expects(:owned_by?).with(user).returns(false)
    sut.enter(room, 0)
    assert_false user.states.rights?
  end

  test "leave resets states for user" do
    user.states.expects(:clear)
    sut.leave
  end

  test "leave removes current room and id for user" do
    user.current_room = room
    user.current_room_id = 1
    sut.leave
    assert_nil user.current_room
    assert_nil user.current_room_id
  end

  test "move returns nil if cannot move to coordinates" do
    user.current_room = room
    heightmap = room.heightmap
    room.stubs(:heightmap).returns(heightmap)
    heightmap.expects(:move_to?).with(1, 2).returns(false)
    assert_nil sut.move(1, 2)
  end

end