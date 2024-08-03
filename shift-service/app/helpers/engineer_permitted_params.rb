# frozen_string_literal: true

class EngineerPermittedParams
  PERMITTED_PARAMS = [
    :name,
    :color
  ].freeze

  class << self
    def permitted_params_for(params)
      permitted_attributes = PERMITTED_PARAMS.dup
      permitted = params.permit(permitted_attributes).to_h

      permitted
    end
  end
end
