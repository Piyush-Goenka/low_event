# frozen_string_literal: true

module Low
  class Event
    include LowType

    attr_reader :action

    def initialize(action: nil)
      @action = action
    end

    # Consider LowEvent a value object.
    def ==(other) = other.class == self.class
    def eql?(other) = self == other
    def hash = [self.class].hash

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
