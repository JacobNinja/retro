module Retro

  class FurniDefinitionManager

    extend Query

    private

    def self.repository
      Repository.furni_definitions
    end

  end
end