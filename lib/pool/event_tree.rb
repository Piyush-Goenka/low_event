# frozen_string_literal: true

module Low
  module Events
    class EventTree
      attr_reader :root_event, :sequence
      attr_accessor :current_event

      def initialize
        @root_event = nil
        @current_event = nil

        @sequence = []
      end

      def branch(event:)
        @sequence << event

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
