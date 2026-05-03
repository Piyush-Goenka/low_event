# frozen_string_literal: true

require_relative 'event_tree'
require_relative '../support/pool_hash'

module Low
  module Events
    class EventPool
      BUFFER_SIZE = 100.freeze

      def initialize
        @pool = Support::PoolHash.new(BUFFER_SIZE)
      end

      def current_event_tree
        @pool[stream_id] || @pool.add(stream_id, EventTree.new)
      end
      
      def event_trees
        @pool
      end

      private

      def stream_id
        Fiber.current.object_id
      end
    end
  end
end
