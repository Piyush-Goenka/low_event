# frozen_string_literal: true

require_relative 'event'

module Low
  module Events
    class StatusEvent < Event
      attr_reader :status, :request

      def initialize(status:, request:)
        super(key: status)

        @status = status
        @request = request
      end
    end
  end
end
