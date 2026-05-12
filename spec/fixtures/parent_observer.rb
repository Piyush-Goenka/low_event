# frozen_string_literal: true

require 'observers'
require_relative 'child_event'
require_relative 'parent_event'

class ParentObserver
  include Observers
  observe 3

  def self.handle(event:) # rubocop:disable Lint/UnusedMethodArgument
    ChildEvent.new(key: 4).trigger
  end
end
