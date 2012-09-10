require File.expand_path('./../../test_helper', __FILE__)

class HeightmapTest < Test::Unit::TestCase

  attr_reader :heightmap, :sut

  def setup
    @heightmap = "xxxx|xxxx|xxxx|xxxx"
    @sut = Retro::Client::Heightmap.new(heightmap)
  end

  def new_item(x, y, rotation, length, width, var_type=0, opts={})
    item = Retro::Item.new({x: x, y: y, rotation: rotation}.merge(opts))
    item.stubs(:furni_definition).returns(Retro::FurniDefinition.new({width: width, length: length, var_type: var_type, flags: "S"}.merge(opts)))
    item
  end

  test "overlays long sittable items on heightmap" do
    assert_equal "xxxx|xxxx|xx00|xxxx", sut.overlay(new_item(2, 2, 0, 2, 1)).heightmap
    assert_equal "xxxx|xxxx|xx0x|xx0x", sut.overlay(new_item(2, 2, 2, 2, 1)).heightmap
    assert_equal "0xxx|0xxx|xxxx|xxxx", sut.overlay(new_item(0, 0, 2, 1, 2)).heightmap
    assert_equal "00xx|xxxx|xxxx|xxxx", sut.overlay(new_item(0, 0, 4, 1, 2)).heightmap
  end

  test "overlays multiple sittable items on heightmap" do
    item = new_item(2, 0, 0, 1, 1)
    item2 = new_item(0, 3, 0, 1, 1)
    assert_equal "xx0x|xxxx|xxxx|0xxx", sut.overlay(item, item2).heightmap
  end

  test "overlays stacked items" do
    item = new_item(0, 0, 0, 1, 1)
    item2 = new_item(0, 0, 0, 1, 1)
    assert_equal "1xxx|xxxx|xxxx|xxxx", sut.overlay(item, item2).heightmap
  end

  test "overlay sets dividers to blocked if closed" do
    item = new_item(0, 0, 0, 1, 1, 2, furni_var: "C")
    assert_equal "Axxx|xxxx|xxxx|xxxx", sut.overlay(item).heightmap
  end

  test "overlay sets dividers to open if open" do
    item = new_item(0, 0, 0, 1, 1, 2, furni_var: "O", flags: "M")
    assert_equal "0xxx|xxxx|xxxx|xxxx", sut.overlay(item).heightmap
  end

end