module Retro

  class RoomCategory

    attr_reader :id, :type, :name, :parent

    def initialize(opts={})
      @id = opts[:id]
      @type = opts[:type]
      @name = opts[:name]
      @parent = opts[:parent]
    end

  end

end