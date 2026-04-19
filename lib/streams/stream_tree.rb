# frozen_string_literal: true

module Low
  module Streams
    class StreamTree
      attr_reader :root_event
      attr_accessor :current_event

      def initialize
        @root_event = nil
        @current_event = nil
      end

      def branch(event:)
        if @root_event.nil?
          @root_event = event
          @current_event = event
        else
          @current_event.children << event
        end
      end
    end
  end
end
