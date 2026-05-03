# frozen_string_literal: true

require 'observers'
require_relative '../support/value_object'

module Low
  # An event represents what is currently happening in your application.
  #
  # Events are mutable in most cases (except for RenderEvent). They are action-driven, representing inputs and outputs
  # that are currently happening in a linear pipeline-like flow. They are present-tense and one-to-many with one return value.
  # The result of the previous event is made available to the next event. [UNRELEASED]
  #
  # Integrations:
  # - EventPool for a tree of events and their child events [IN PROGRESS]
  # - Observers for observer pattern via an event-centric API [IN PROGRESS]
  # - LowState for state machines to trigger multiple actions [UNLRELEASED]
  class Event
    include LowType
    include Support::ValueObject

    attr_reader :key, :action, :created_at
    attr_accessor :children

    ROOT_FIBER = Fiber.current

    def initialize(key:, action: nil, children: [])
      @key = key
      @action = action
      @children = children

      @created_at = Time.now.to_i
    end

    def trigger
      event_tree = branch
      key = Observers::Keys[@key] || raise(Observers::Keys::MissingKeyError)
      key.trigger(event: self) { restore_level(event_tree:) }
    end

    def take
      event_tree = branch
      key = Observers::Keys[@key] || raise(Observers::Keys::MissingKeyError)
      key.take(event: self) { restore_level(event_tree:) }
    end

    private

    def branch
      # Don't create a singular ever-growing stream tree.
      return nil if ROOT_FIBER == Fiber.current

      event_tree = Low::Providers['low.event.pool'].current_event_tree
      event_tree.branch(event: self)
    end

    def restore_level(event_tree:)
      event_tree.current_event = self if event_tree.respond_to?(:current_event)
    end

    class << self
      def trigger(**kwargs)
        new(**kwargs).trigger
      end

      def take(**kwargs)
        new(**kwargs).take
      end

      def inherited(child)
        child.include LowType
      end
    end
  end
end
