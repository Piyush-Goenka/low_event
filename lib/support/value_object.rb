# frozen_string_literal: true

module ValueObject
  def ==(other) = other.class == self.class
  def eql?(other) = self == other
  def hash = [self.class].hash
end
