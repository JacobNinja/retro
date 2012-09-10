module Retro

  module Attrs

    def attr(*attrs)
      attrs.each do |attr|
        define_method attr do
          instance_variable_get("@#{attr}") || instance_variable_get("@opts")[attr]
        end
      end
    end

  end

end