# frozen_string_literal: true

class ContractSerializer < ActiveModel::Serializer
  attribute :id
  attribute(:start_date) { object.start_date.iso8601 }
  attribute(:end_date) { object.end_date.iso8601 }
  attribute :start_hour_weekday
  attribute :end_hour_weekday
  attribute :start_hour_weekend
  attribute :end_hour_weekend
  attribute :service_id
end
