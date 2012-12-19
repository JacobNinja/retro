require File.expand_path('./../../test_helper', __FILE__)

class PathFinderTest < Test::Unit::TestCase

  test "directions returns directions to coordinates" do
    heightmap_data = "0000|0000|0000|0000"
    heightmap = Retro::Client::Heightmap.new(heightmap_data)
    sut = Retro::PathFinder.new(heightmap)
    assert_equal [[1, 1, 0], [2, 2, 0], [3, 3, 0]], sut.directions(0, 0, 3, 3).to_a
  end

  test "directions move to blocked area" do
    heightmap_data = "xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxxxxxxxxxx"
    heightmap = Retro::Client::Heightmap.new(heightmap_data)
    item1 = ItemFactory.new(x: 4, y: 9, length: 2).generate
    item2 = ItemFactory.new(x: 6, y: 9, length: 2).generate
    item4 = ItemFactory.new(x: 8, y: 9, length: 2).generate
    item3 = ItemFactory.new(x: 10, y: 9, length: 2).generate
    sut = Retro::PathFinder.new(heightmap.overlay(item1, item2, item3, item4))
    sut.directions(10, 12, 6, 4).to_a
  end

end