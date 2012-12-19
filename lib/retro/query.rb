module Retro

  module Query

    def find(id)
      repository.find(id)
    end

    def update(id, attrs)
      repository.update(id, attrs)
    end

    def filter(attrs)
      repository.filter(attrs)
    end

    def create(attrs)
      repository.create(attrs)
    end

    def all
      repository.all
    end

  end

end