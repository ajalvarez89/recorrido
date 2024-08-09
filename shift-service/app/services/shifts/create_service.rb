# frozen_string_literal: true

module Shifts
  class CreateService
    TIME_FORMAT = '%H:%M'

    def initialize(params)
      @contract = Contract.find(params[:id])
    end

    def execute!
      generate_shifts!
    end

    private

    attr_reader :params, :contract

    def generate_shifts!
      (contract.start_date.to_date..contract.end_date.to_date).each do |date|
        day_type = weekend?(date) ? :weekend : :weekday
        create_shifts_for_day(date, day_type)
      end
    end

    def create_shifts_for_day(date, day_type)
      start_hour = contract.send("start_hour_#{ day_type }")
      end_hour = contract.send("end_hour_#{ day_type }")

      (start_hour...end_hour).each do |hour|
        Shift.create!(
          contract_id: contract.id,
          date:,
          day_of_week: date.strftime('%A'),
          start_hour: format_hour(hour),
          end_hour: format_hour(hour + 1)
        )
      end
    end

    def weekend?(date)
      date.saturday? || date.sunday?
    end

    def format_hour(hour)
      Time.parse("#{ hour }:00").strftime(TIME_FORMAT)
    end
  end
end
