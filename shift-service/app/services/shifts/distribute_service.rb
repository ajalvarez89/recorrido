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

    #TODO - Its missing to improve the distribution of engineers properly
    def redistribute_engineers
      shifts.each do |shift|
        engineers = shift.engineers
        next if engineers.blank?

        engineers.each do |engineer|
          assignments << { shift: shift, engineer: engineer }
        end
      end

      assignments
    end

    def update_shifts
      assignments.each do |assignment|
        engineer_shift = assignment[:shift].engineer_shifts.find_by(engineer: assignment[:engineer])
        return unless engineer_shift

        engineer_shift.update(status: :confirmed)
      end
    end
  end
end
