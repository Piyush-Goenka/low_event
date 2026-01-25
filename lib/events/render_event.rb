# frozen_string_literal: true

module Low
  module Events
    RenderEvent = Data.define(:action, :render) do
      def initialize(action: :render, render: nil)
        super
      end
    end
  end
end
