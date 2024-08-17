# frozen_string_literal: true

class ShiftUpdatedEvent < BaseEvent
  ROUTING_KEY = 'shifts.updated'
end
