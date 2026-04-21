# frozen_string_literal: true

require_relative 'pool_hash'
require_relative 'stream_tree'

module Low
  module Streams
    class StreamPool
      BUFFER_SIZE = 100.freeze

      def initialize
        @pool = PoolHash.new(BUFFER_SIZE)
      end   

      def current_stream
        @pool[stream_id] || @pool.add(stream_id, StreamTree.new)
      end
      
      def streams
        @pool
      end

      private

      def stream_id
        Fiber.current
      end
    end
  end
end
