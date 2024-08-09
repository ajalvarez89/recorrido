# frozen_string_literal: true

class TimeRangeValidator < ActiveModel::Validator
  def validate(record)
    validate_hour_range(record, :start_hour_weekday, :end_hour_weekday, 'weekdays')
    validate_hour_range(record, :start_hour_weekend, :end_hour_weekend, 'weekends')
  end

  private

  def validate_hour_range(record, start_hour_attr, end_hour_attr, period)
    start_hour = record.send(start_hour_attr)
    end_hour = record.send(end_hour_attr)

    return if start_hour.nil? || end_hour.nil?

    return unless start_hour >= end_hour

    record.errors.add(start_hour_attr, I18n.t('errors.messages.invalid_start_hours', period:))
  end
end
