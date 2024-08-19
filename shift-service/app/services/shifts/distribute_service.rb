# frozen_string_literal: true

module Shifts
  class DistributeService
    def initialize(params)
      @contract = Contract.find(params[:contract_id])
      @shifts = contract.shifts.with_engineers
      @assignments = []
    end

    def execute!
      update_all_to_scheduled
      redistribute_engineers
      update_shifts
    end

    private

    attr_reader :contract, :shifts, :assignments

    def update_all_to_scheduled
      EngineerShift.where(shift: shifts, status: :confirmed).update_all(status: :scheduled)
    end

    def redistribute_engineers
      engineer_turns_count = Hash.new(0)

      all_engineers = shifts.flat_map(&:engineers).uniq

      # Internal: Implementing round-robin strategy for distribution
      shifts.each do |shift|
        next if shift.engineers.empty?

        available_engineers = shift.engineers.sort_by { |engineer| engineer_turns_count[engineer] }

        selected_engineer = available_engineers.first
        assignments << { shift: shift, engineer: selected_engineer }
        engineer_turns_count[selected_engineer] += 1

        if available_engineers.size == 1
          selected_engineer = available_engineers.first
          assignments << { shift: shift, engineer: selected_engineer }
        end
      end
    end

    def update_shifts
      assignments.each do |assignment|
        engineer_shift = assignment[:shift].engineer_shifts.find_by(engineer: assignment[:engineer])
        next unless engineer_shift

        engineer_shift.update(status: :confirmed)
      end
    end
  end
end
