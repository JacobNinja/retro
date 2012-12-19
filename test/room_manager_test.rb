require './test_helper'

class RoomManagerTest < Test::Unit::TestCase

  attr_reader :room, :items_repository, :item, :heightmap, :sut

  def setup
    @items_repository = TestRepository.new
    @item = ItemFactory.new(id: 1, x: 0, y: 0).sittable
    @room = RoomFactory.default([item])
    @heightmap = @room.heightmap
    @room.stubs(:heightmap).returns(heightmap)
    @room.stubs(:items).returns([item])
    @sut = Retro::RoomManager.new(room)
    sut.stubs(:items_repository).returns(items_repository)
  end

  test "move returns nil if item not found" do
    room.stubs(:items).returns([])
    assert_equal nil, sut.move(item.id, 1, 1, 1)
  end

  test "move saves coordinates of item" do
    items_repository.expects(:update).with(item.id, x: 1, y: 2, z: 0, rotation: 4, room_id: room.id)
    sut.move(item.id, 1, 2, 4)
  end

  test "move returns updated item" do
    new_item = sut.move(item.id, 1, 2, 4)
    assert_equal item.id, new_item.id
    assert_equal 1, new_item.x
    assert_equal 2, new_item.y
    assert_equal 0, new_item.z
    assert_equal 4, new_item.rotation
  end

  test "move returns nil if position is blocked" do
    heightmap.expects(:blocked?).with(1, 2, item).returns(true)
    items_repository.expects(:update).never
    assert_nil sut.move(item.id, 1, 2, 3)
  end

  test "move updates z according to heightmap" do
    heightmap.expects(:new_item_height).with(1, 2).returns(10)
    new_item = sut.move(item.id, 1, 2, 3)
    assert_equal 10, new_item.z
  end

end