# frozen_string_literal: true

class ShiftSerializer < ActiveModel::Serializer
  attribute :id
  attribute :contract_id
  attribute(:date) { object.date.iso8601 }
  attribute :day_of_week
  attribute :start_hour
  attribute :end_hour

  has_many :engineer_shifts
end
