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
        if size >= @max_size && !key?(key)
          # TODO: Notify event pool that item was removed.
          old_key, old_value = shift
        end

        self[key] = value
      end
    end
  end
end
