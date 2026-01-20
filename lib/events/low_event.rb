# frozen_string_literal: true

require 'observers'

module Low
  Event = Data.define(:action) do
    include LowType

    def initialize(action: nil)
      @action = action
    end

    # Integrate with Observers, providing a self-contained API via an event's class.
    class << self
      def trigger(**kwargs)
        observable = Observers::Observables[self] || raise(Observers::Observables::MissingKeyError)
        event = new(**kwargs)
        observable.trigger action: event.action, event:
      end

      def inherited(child)
        child.include LowType
      end
    end
  end
end
