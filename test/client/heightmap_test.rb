require File.expand_path('./../../test_helper', __FILE__)

class HeightmapTest < Test::Unit::TestCase

  attr_reader :heightmap, :sut

  def setup
    @heightmap = "xxxx|xxxx|xxxx|xxxx"
    @sut = Retro::Client::Heightmap.new(heightmap)
  end

  def new_item(x, y, opts={})
    required_opts = {x: x, y: y, rotation: 0, length: 1, width: 1}
    ItemFactory.new(required_opts.merge(opts))
  end

  test "overlays long sittable items on heightmap" do
    assert_equal "xxxx|xxxx|xx00|xxxx", sut.overlay(new_item(2, 2, length: 2).sittable).heightmap
    assert_equal "xxxx|xxxx|xx0x|xx0x", sut.overlay(new_item(2, 2, rotation: 2, length: 2).sittable).heightmap
    assert_equal "0xxx|0xxx|xxxx|xxxx", sut.overlay(new_item(0, 0, rotation: 2, width: 2).sittable).heightmap
    assert_equal "00xx|xxxx|xxxx|xxxx", sut.overlay(new_item(0, 0, rotation: 4, width: 2).sittable).heightmap
  end

  test "overlays multiple sittable items on heightmap" do
    item = new_item(2, 0).sittable
    item2 = new_item(0, 3).sittable
    assert_equal "xx0x|xxxx|xxxx|0xxx", sut.overlay(item, item2).heightmap
  end

  test "overlays stackable items" do
    item = new_item(0, 0, z: 0.0).stackable
    item2 = new_item(0, 0, z: 1.0).stackable
    assert_equal "1xxx|xxxx|xxxx|xxxx", sut.overlay(item, item2).heightmap
  end

  test "overlay sets dividers to blocked if closed" do
    item = new_item(0, 0).divider(false)
    assert_equal "Axxx|xxxx|xxxx|xxxx", sut.overlay(item).heightmap
  end

  test "overlay sets dividers to open if open" do
    item = new_item(0, 0).divider
    assert_equal "Oxxx|xxxx|xxxx|xxxx", sut.overlay(item).heightmap
  end

  test "overlay blocked if item has no flags" do
    item = new_item(0, 0).blocked
    assert_equal "Axxx|xxxx|xxxx|xxxx", sut.overlay(item).heightmap
  end

  test "move_to? blocked if item and not sittable" do
    item = new_item(0, 0).blocked
    assert_false sut.overlay(item).move_to?(0, 0)
  end

  test "move_to? not blocked if no item" do
    assert_true sut.move_to?(0, 0)
  end

  test "move_to? not blocked if sittable item" do
    item = new_item(0, 0).sittable
    assert_true sut.overlay(item).move_to?(0, 0)
  end

  test "move_to? not blocked if layable item" do
    item = new_item(0, 0).layable
    assert_true sut.overlay(item).move_to?(0, 0)
  end

  test "move_to? not blocked if standable item" do
    item = new_item(0, 0).standable
    assert_true sut.overlay(item).move_to?(0, 0)
  end

end