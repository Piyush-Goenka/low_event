# frozen_string_literal: true

module Low
  module Support
    class PoolHash < Hash
      def initialize(max_size)
        @max_size = max_size

        super()
      end

      def add(key, value)
        # Prune the hash when a new item added.
        shift if size >= @max_size && !key?(key)
        self[key] = value
      end
    end
  end
end
