module Retro
  module Handlers

    class Handler

      attr_reader :data

      def initialize(session, data)
        @session = session
        @data = ServerMessage.new(data)
      end

      def call
        Client::Message.new(header, body)
      end

      def header
        self.class.instance_variable_get("@header")
      end

      def body
        self.class.instance_variable_get("@body")
      end

      def user
        @session.user
      end

    end

  end
end