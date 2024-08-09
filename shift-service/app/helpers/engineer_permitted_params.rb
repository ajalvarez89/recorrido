# frozen_string_literal: true

class EngineerPermittedParams
  PERMITTED_PARAMS = %i[name].freeze

  class << self
    def permitted_params_for(params)
      PERMITTED_PARAMS.dup
      params.permit(*PERMITTED_PARAMS).to_h
    end
  end
end
