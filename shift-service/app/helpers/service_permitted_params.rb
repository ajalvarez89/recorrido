# frozen_string_literal: true

class ServicePermittedParams
  PERMITTED_PARAMS = %i[name description].freeze

  class << self
    def permitted_params_for(params)
      permitted_attributes = PERMITTED_PARAMS.dup
      params.permit(permitted_attributes).to_h
    end
  end
end
