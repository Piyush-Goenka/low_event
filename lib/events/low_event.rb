# frozen_string_literal: true

module Low
  Event = Data.define(:action) do
    include LowType

    def initialize(action: nil)
      @action = action
    end

    def self.inherited(child)
      child.include LowType
    end
  end
end
