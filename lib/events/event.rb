# frozen_string_literal: true

require 'observers'

module Low
  # An event represents what is currently happening in your application.
  #
  # Events are mutable in most cases (except for RenderEvent). They are action-driven, representing inputs and outputs
  # that are currently happening in a linear pipeline-like flow. They are present-tense and one-to-many with one return value.
  # The result of the previous event is made available to the next event. [UNRELEASED]
  #
  # Integrations:
  # - EventStream for a tree of events and their child events [IN PROGRESS]
  # - LowState for state machines, allowing events to perform multiple actions [UNLRELEASED]
  # - Observers for observer pattern via an event-centric API [IN PROGRESS]
  class Event
    include LowType

    attr_reader :key, :action
    attr_accessor :children

    def initialize(key:, action: nil, children: [])
      @key = key
      @action = action
      @children = children
    end

    def trigger
      key = Observers::Keys[@key] || raise(Observers::Keys::MissingKeyError)
      key.trigger event: self
    end

    def take
      key = Observers::Keys[@key] || raise(Observers::Keys::MissingKeyError)
      key.take event: self
    end

    # Consider LowEvent a value object.
    def ==(other) = other.class == self.class
    def eql?(other) = self == other
    def hash = [self.class].hash

    class << self
      def trigger(**kwargs)
        key = Observers::Keys[@key] || raise(Observers::Keys::MissingKeyError)
        key.trigger event: new(**kwargs)
      end

      def take(**kwargs)
        key = Observers::Keys[@key] || raise(Observers::Keys::MissingKeyError)
        key.trigger event: new(**kwargs)
      end

      def inherited(child)
        child.include LowType
      end
    end
  end
end
