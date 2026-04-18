# frozen_string_literal: true

module Low
  class EventStream
    BUFFER_SIZE = 100.freeze

    def initialize
      @streams = Hash.new(capacity: BUFFER_SIZE)
      @stream_ids = Array.new(BUFFER_SIZE)
      @cursor = 0
    end

    def push(event:)
      @streams[@cursor] = nil
    end
  end
end
