# frozen_string_literal: true

module Low
  module Events
    RenderEvent = Data.define(:action, :props) do
      # TODO: Duplicate props when used in a parallelized situation (antlers: "<{ :parallelize }>")
      def initialize(action: :render, props: {})
        super
      end
    end
  end
end
