# frozen_string_literal: true

require 'observers'

module Low
  class Event
    include LowType

    attr_reader :action
    attr_accessor :children

    def initialize(action: nil, children: [])
      @action = action
      @children = children
    end

    # Consider LowEvent a value object.
    def ==(other) = other.class == self.class
    def eql?(other) = self == other
    def hash = [self.class].hash

    # Integrate with Observers with an event-centric API.
    class << self
      def trigger(**kwargs)
        event = new(**kwargs)

        key = Observers::Keys[self] || raise(Observers::Keys::MissingKeyError)
        key.trigger action: event.action, event:
      end

      def inherited(child)
        child.include LowType
      end
    end
  end
end
