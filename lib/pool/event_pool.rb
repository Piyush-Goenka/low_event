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

      def current_stream
        @pool[stream_id] || @pool.add(stream_id, EventTree.new)
      end
      
      def events
        @pool
      end

      private

      def stream_id
        Fiber.current
      end
    end
  end
end
