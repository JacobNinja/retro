require './test_helper'

class MoveStuffTest < HandlerTestCase

  def encode(int)
    Retro::Encoding::VL64.encode(int)
  end

  attr_reader :x, :y, :rotation, :data, :item, :sut, :room_manager

  def setup
    user.current_room = RoomFactory.default
    @x = 2
    @y = 3
    @rotation = 4
    @item = ItemFactory.new(id: 1, x: x, y: y, width: 1, length: 1).sittable
    @data = "#{item.id} #{x} #{y} #{rotation}"
    @sut = Retro::Handlers::MoveStuff.new(session, data)
    @room_manager = Retro::RoomManager.new(user.current_room)
    Retro::RoomManager.expects(:new).with(user.current_room).returns(room_manager)
  end

  test "calls room manager with item id and new coordinates" do
    room_manager.expects(:move).with(item.id, x, y, rotation)
    sut.call
  end

  test "returns nil if item not returned by manager" do
    room_manager.expects(:move).returns(nil)
    assert_nil sut.call
  end

  test "returns a move furni response" do
    room_manager.expects(:move).returns(item)
    result = sut.call[0]
    assert_equal "A_", result.header
    assert_equal "#{item.id}#{2.chr}#{item.sprite}#{2.chr}#{encode(x)}#{encode(y)}#{encode(item.width)}#{encode(item.length)}#{encode(item.rotation)}#{item.z}#{2.chr}#{item.col}#{2.chr}#{2.chr}#{encode(item.teleport_id)}#{item.furni_var}#{2.chr}",
                 result.body
  end

  test "returns a new heightmap response" do
    room_manager.expects(:move).returns(item)
    result = sut.call[1]
    assert_equal "@_", result.header
  end

end