# frozen_string_literal: true

require 'observers'
require_relative 'event_tree'
require_relative '../support/pool_hash'

module Low
  module Events
    class EventPool
      include Observers

      BUFFER_SIZE = 100.freeze

      def initialize
        @pool = Support::PoolHash.new(BUFFER_SIZE)
      end

      def current_event_tree
        return @pool[request_id] if @pool[request_id]

        event_tree = @pool.add(request_id, EventTree.new(request_id:))
        trigger action: :new_event_tree, event: event_tree

        event_tree
      end
      
      def event_trees
        @pool
      end

      private

      def request_id
        Fiber.current.object_id
      end
    end
  end
end
