# frozen_string_literal: true

require 'observers'

require_relative '../lib/low_event'

RSpec.describe LowEvent do
  subject(:low_event) { described_class.new }
end
