# frozen_string_literal: true

class ShiftPermittedParams
  PERMITTED_PARAMS = [
    engineer_shifts_attributes: %i[
      id
      engineer_id
      status
      _destroy
    ]
  ].freeze

  class << self
    def permitted_params_for(params)
      permitted_attributes = PERMITTED_PARAMS.dup
      params.permit(*permitted_attributes).to_h
    end
  end
end
