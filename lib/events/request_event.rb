# frozen_string_literal: true

require_relative 'low_event'

module Low
  module Events
    class RequestEvent < Event
      attr_reader :request

      def initialize(action: :handle, request:)
        super()

        @request = request
      end
    end
  end
end
