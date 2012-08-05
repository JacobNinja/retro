module Retro
  module Handlers

    def self.null(header_int)
      Class.new(Handler) do
        def call
          encoded_header = Encoding::Base64.encode(header_int)
          p "No mapping found for #{encoded_header}, #{header_int}"
          nil
        end

        def header_int
          self.class.instance_variable_get("@header_int")
        end
      end.tap {|klass| klass.instance_variable_set("@header_int", header_int) }
    end

  end
end