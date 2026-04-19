# frozen_string_literal: true

require 'low_dependency'
require 'low_type'
require 'observers'

require_relative 'events/event'
require_relative 'events/render_event'
require_relative 'events/request_event'
require_relative 'events/response_event'
require_relative 'events/status_event'
require_relative 'factories/response_factory' # TODO: Find out who's using this and require it there.
require_relative 'streaming/event_pool'

LowDependency.provide('low.event.pool') do
  Low::Streaming::StreamPool.new
end

LowEvent = Low::Event
