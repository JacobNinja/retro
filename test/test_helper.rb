require 'test/unit'
require 'mocha'
require 'sequel'

require File.expand_path('./../../lib/retro', __FILE__)
DB = Sequel.mock

class HandlerTestCase < Test::Unit::TestCase

  def user
    @user ||= Retro::User.new
  end

  def session
    @session ||= Retro::Session.new(stub, user)
  end

end

class RoomFactory

  def self.default(items=[])
    room_type = RoomTypeFactory.a
    Retro::Room.new(id: 1, name: "Test Room", description: "Description", type: room_type, items: items)
  end

end

class RoomTypeFactory

  def self.a
    heightmap = "xxxxxxxxxxxx|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxxxxxxxxxx|xxxxxxxxxxxx"
    Retro::RoomType.new(max_guests: 25, heightmap: heightmap, ccts: "0", model: "model_a", guest: 1, start_x: 3, start_y: 5, start_z: 0,
                        max_ascend: 1.5, max_descend: 3.5, user_type: 1, )
  end

end

class ItemFactory

  def initialize(opts={})
    @opts = opts
  end

  def divider(open=true)
    signature = open ? "O" : "C"
    divider_opts = {var_type: 2, furni_var: signature}
    generate(divider_opts)
  end

  def sittable
    generate(flags: "S")
  end

  def pathable
    generate(flags: "P")
  end

  def standable
    generate(flags: "W")
  end

  def layable
    generate(flags: "L")
  end

  def stackable
    generate(flags: "O")
  end

  def blocked
    generate(flags: "")
  end

  def generate(extra_opts={})
    default_opts = {height: 1, length: 1, width: 1, x: 1, y: 1, z: 0.0}.merge(@opts)
    opts = default_opts.merge(extra_opts)
    Retro::Item.new(opts).tap do |item|
      furni_definition = Retro::FurniDefinition.new(opts)
      item.stubs(:furni_definition).returns(furni_definition)
    end
  end

end

class TestRepository

  def find(id)
    # no op
  end

  def update(id, attrs={})
    # no op
  end

end