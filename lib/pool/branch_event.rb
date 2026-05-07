# frozen_string_literal: true

require_relative '../events/hidden_event'

module Low
  module Events
    class BranchEvent < HiddenEvent
      attr_reader :event_tree, :event

      def initialize(event_tree:, event:)
        super(key: BranchEvent, action: :branch)
        
        @event_tree = event_tree
        @event = event
      end
    end
  end
end
