# frozen_string_literal: true

module Shifts
  class UpdateService
    def initialize(shift:, params:)
      @shift = shift
      @params = params
    end

    def execute!
      assign_shift_attributes
      shift.save!
    end

    private

    attr_reader :shift, :params

    def assign_shift_attributes
      shift.assign_attributes(params)
    end
  end
end
